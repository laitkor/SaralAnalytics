class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find(User.search_by(email: params[:email])[0])
    if user.present?
      user.send_password_reset 
    end
    redirect_to log_in_path, :notice => "Email sent with password reset instructions."
  end

  def edit
    @user = User.find(User.search_by(password_reset_token: params[:id])[0])
  end

  def update
  
    @user = User.find(User.search_by(password_reset_token: params[:id])[0])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to log_in_path, :notice => "Password has been reset!"
    else
      render :edit
    end
  end

end
