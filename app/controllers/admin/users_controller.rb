class Admin::UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :create]
  before_action :set_last_page, only: [:new, :edit]
  before_action :require_admin
  layout "admin"

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:notice] = "User was successfully created."
      if params[:commit] == "Create and add another"
        redirect_to new_admin_user_path
      else
        redirect_to admin_path
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to admin_path
    else
      render :edit
    end
  end

  def confirm
  end

  def destroy
    @user.destroy
    flash[:notice] = "User was successfully deleted."
    redirect_to admin_users_path
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :password, :matched, :matched_id, :role)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_last_page
      session[:last_page] = request.env["HTTP_REFERER"]
    end

end