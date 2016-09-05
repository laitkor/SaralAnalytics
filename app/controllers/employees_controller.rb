class EmployeesController < ApplicationController
  
  before_filter :login_required

  def new
    @employee = Employee.new
    @user = User.new
    @employees_project = EmployeesProjects.new
    if !(Company.search_by(user_id: current_user.key).blank?)
      @company_id = Company.find(Company.search_by(user_id: current_user.key)[0]).key rescue nil
      @company_name = Company.find(Company.search_by(user_id: current_user.key)[0]).name rescue nil
    else
      @company_id = Employee.find(Employee.search_by(user_id: current_user.key)[0]).company_id rescue nil
      @company_name = Company.find(Employee.find(Employee.search_by(user_id: current_user.key)[0]).company_id).name rescue nil
    end
    @emp_list = Employee.search_by(company_id: (Company.search_by(user_id: current_user.key)[0])) rescue nil
  end

  def create
    @employee = Employee.new(params[:employee])
    @user = User.new(params[:user])
    @employees_project = EmployeesProjects.new
    @user.role_id = Role.search_by(name: "Employee")[0]
    if params[:employee][:password] != ""
      @password = params[:user][:password]
    end
    if [@employee, @user].map { |rec| rec.valid? }.all?
      @user.save        
      @employee.company_id = Company.find(Company.search_by(user_id: current_user.key)[0]).key
      @employee.user_id = @user.key
      @employee.save!
      UserMailer.registration_confirmation(@user, @password).deliver
      EmployeesProjects.create_all params[:employees_projects].merge(employee_id: @employee.key)
      redirect_to employees_path, :notice => "Successfully created new Employee!"
    else
      render "new"
    end
  end

  def index
    @employee_list = Employee.search_by(company_id: Company.search_by(user_id:current_user.key)[0])
    @employees = @employee_list.map { |emp_id| Employee.find emp_id }
    if @employees.blank?
      redirect_to new_employee_path
      return
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @employees }
    end
  end

  def edit
    @employee = Employee.find(params[:id])
    @user = User.find(@employee.user_id)
    @emp_projects  = EmployeesProjects.find(
      EmployeesProjects.search_by(
        employee_id: @employee.key
      )
    )
  end

  # PUT /employees/1
  # PUT /employees/1.json
  def update
    @employee = Employee.find(params[:id])
    @user = User.find(@employee.user_id)    
    @emp_projects  = EmployeesProjects.find(
      EmployeesProjects.search_by(
        employee_id: @employee.key
      )
    )
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    respond_to do |format|
      if @employee.update_attributes(params[:employee]) && EmployeesProjects.update_all(params) #&& @user.update_attributes(params[:user]) 
        format.html {redirect_to employees_path, notice: 'Employee is successfully updated.'}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

end
