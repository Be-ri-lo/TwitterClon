class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :following, :followers]
  before_action :logged_in_user, only: [:edit, :update, :destroy]

  def index
    @q = User.page(params[:page]).ransack(params[:q])
    @users = @q.result(distinct: true)
    
  end

  def show
    @tweet = current_user.tweets.build if logged_in?
    @user = User.new
    @friend = Friend.where(user_id: current_user.id, friend_id: @user.id).first_or_initialize if current_user
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      log_in @user
      flash[:success] = "Welcome to Twitter Clone!"
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Update your profile"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_url
  end

  
private
  def set_user
    @user = User.find_by!(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
