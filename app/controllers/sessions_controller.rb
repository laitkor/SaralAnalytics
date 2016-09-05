class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    project = Project.for_user(user).first
    if user
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.key
      else
        cookies[:auth_token] = user.key
      end
      if project
        redirect_to dashboard_admin_index_path, :notice => "Logged in!"
      else
        session[:user_id] = user.key
        redirect_to startup_projects_path, :notice => "Logged in!"
      end
    else
      redirect_to log_in_path, :notice => "Invalid email or password"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    session[:project] = nil
    redirect_to log_in_path, :notice => "Logged out!"
  end
end
