class AdminController < ApplicationController
  before_action :require_admin, except: [:check, :new, :create]
  layout "admin"

  def new
  end

  def create
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password]) && @user.role == "admin"
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully logged in."
      redirect_to admin_path
    else
      flash[:error] = "Your username or password was incorrect."
      redirect_to admin_login_path
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out."
    redirect_to root_path
  end

  def check
    if !logged_in?
      redirect_to admin_login_path
    elsif !admin?
      flash[:notice] = "You are not allowed to do that."
      redirect_to root_path
    else
      redirect_to admin_users_path
    end
  end

  private

end