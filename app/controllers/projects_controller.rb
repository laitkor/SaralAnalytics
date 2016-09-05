class ProjectsController < ApplicationController

  before_filter :login_required

  def new
    @project = Project.new
  end

  def create
    if !(Company.search_by(user_id: current_user.key).blank?)
      @comp_id = Company.find(Company.search_by(user_id: current_user.key)[0]).key rescue nil
    else
      @comp_id = Company.find(Employee.find(Employee.search_by(user_id: current_user.key)[0]).company_id).key rescue nil
      @employees_project = EmployeesProjects.new
    end
    @project = Project.new(params[:project].merge(user_id:current_user.key, company_id: @comp_id))
    session[:return_to] ||= request.referer
    if @project.save
      if current_employee
        EmployeesProjects.create({
          employee_id: Employee.search_by(user_id: current_user.key)[0],
          project_id: @project.key,
          user_id: current_user.key,
          company_id: @comp_id,
          company_name: Company.find(@comp_id).name
        })
      end
      session[:project] = @project.key
      redirect_to learn_projects_path, :notice => "New project created successfully!"
    else
      redirect_to session.delete(:return_to), :notice => "Sorry, this name has already been taken. Please type another name!!!"
    end
  end

  def index
    @projects = Project.list
  end

  def startup
    render layout: false
  end

  def show
    @project = Project.find(session[:project])

    @queried_project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def learn
    @project_list = Project.for_user(current_user).sort_by(&:created_at).reverse
  end

  def get_key
    session[:project] = params[:project_key]
    render json: {success: true}
  end



  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    employee_projects = EmployeesProjects.find EmployeesProjects.search_by(project_id: @project.key)
    employee_projects.map &:destroy
    @project.destroy
    respond_to do |format|
      if Project.list.blank?
        format.html { redirect_to startup_projects_path }
      else
        format.html { redirect_to learn_projects_path }
        format.json { head :no_content }
      end
    end
  end

end
