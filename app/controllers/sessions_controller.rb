class SessionsController < ApplicationController
  before_action :require_user, only: [:home, :destroy]
  layout "application"

  def home
    @match = User.find(current_user.matched_id) if current_user.matched
  end

  def new
    if logged_in?
      redirect_to home_path
    end
  end

  def create
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/home'
    else
      flash[:error] = "Your username or password was incorrect."
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out."
    redirect_to root_path
  end

  def pick
    pick_user
    @match = User.find(current_user.matched_id) if current_user.matched

    respond_to do |format|
      format.js {}
    end
  end

  private
    def require_user
      if !logged_in?
        flash[:error] = "You must be logged in to do that."
        redirect_to root_path
      end
    end

    def picked_users
      users = User.all
      picked_users = []

      users.each do |user|
        picked_users << user.matched_id if (user.matched_id != 0 || user.matched_id != nil)
      end

      picked_users
    end

    def pick_user
      users = User.all
      user_arr = []
      match = 0

      users.each do |user|
        if !(picked_users.include?(user.id))
          user_arr << user.id
          puts user_arr
        end
      end

      begin
        match = user_arr.sample
      end until (match != current_user.id)

      current_user.matched = true
      current_user.matched_id = match

      current_user.save

    end

end