class UsersController < ApplicationController 
  
  before_filter :login_required

  def new
    @user = User.new
  end
  
end
