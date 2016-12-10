class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user, only:[:edit, :profile, :update, :destroy]

  def index
    if params[:id]
      @users = User.where('id < ?', params[:id]).limit(2)
    else
      @users = User.all.limit(2)
    end
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def edit
  end

  def profile
  end

  def matches
    @matches = current_user.friendships.where(state: "ACTIVE").map(&:friend) + current_user.inverse_friendships.where(state: "ACTIVE").map(&:user)
  end

  def update
    if @user.update(user_params)
      respond_to do |format|
        format.html {redirect_to users_path}
      end
    else
      redirect_to edit_user_path(@users)
    end
  end

  def destroy
    if @user.destroy
      redirect_to root_path
      session[:user_id] = nil 
      session[:omniauth] = nil 
    else
      redirect_to edit_user_path(@user)
    end
  end

  private
    def set_user
      @users = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:interest, :bio, :image, :location, :date_of_birth)
    end
end
