class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :current_project, :current_company, :current_employee
  before_filter :current_project

  private
  
  def current_user
    @current_user ||= User.find(cookies[:auth_token]) if cookies[:auth_token]
  end

  def current_company
    Company.search_by(user_id: current_user.key).first rescue nil
  end

  def current_employee
    Employee.search_by(user_id: current_user.key).first rescue nil
  end

  def login_required
    redirect_to log_in_path if current_user.blank?
  end
  
  def current_project
    @project = Project.find session[:project]
    if !@project and current_user 
      first = Project.for_user(current_user).first
      session[:project] = first.try(:key)
      @project = Project.find session[:project]
    end
    @project
  end

  def check_current_user_project
    if current_user && !current_project
      redirect_to startup_projects_path
    end
  end
end