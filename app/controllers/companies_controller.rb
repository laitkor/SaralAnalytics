class CompaniesController < ApplicationController

  before_filter :login_required, except: [:new, :create]
  
  def new
    @company = Company.new
    @user = User.new
  end

  def create
    @company = Company.new(params[:company])
    @user = User.new(params[:user].merge(role_id:Role.search_by(name: "Company")[0]))
    if params[:user][:password] != ""
      @password = params[:user][:password]
    end
    if [@company, @user].map { |rec| rec.valid? }.all?
      @user.save  
      @company.user_id = @user.key
      @company.save
      session[:user_id] = @user.key
      cookies[:auth_token] = @user.key
      UserMailer.registration_confirmation(@user, @password).deliver
      redirect_to startup_projects_path, :notice => "Congratulations! You have Signed up successfully"
    else
      render :template => 'companies/new'
    end
  end

  def edit
    @company = Company.find(params[:id])
    @user = User.find(@company.user_id)
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])
    @user = User.find(@company.user_id)

    respond_to do |format|
      if @company.update_attributes(params[:company]) && @user.update_attributes(params[:user])
        project = Project.for_user(current_user).first
        if project
          format.html {redirect_to dashboard_admin_index_path, notice: 'Company is successfully updated.'}
          format.json { head :no_content }
        else
          format.html { redirect_to startup_projects_path, notice: 'Company is successfully updated.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end


end
