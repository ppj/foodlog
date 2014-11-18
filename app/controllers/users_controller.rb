class UsersController < ApplicationController

  before_action :set_user, except: [:new, :create, :index]

  before_action :match_user, only: [:edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'You are registered successfully'
      redirect_to user_path(@user)
    else
      render :new
    end

  end

  def edit
  end

  def update

    if @user.update(user_params)
      session[:user_id] = @user.id
      flash[:success] = 'Profile updated successfully'
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
  end

  def index
    @users = User.all
  end

  private

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def user_params
    params.require(:user).permit!
  end

  def match_user
    unless @user == current_user
      flash[:danger] = "You do not have permission to do that."
      redirect_to user_path(@user)
    end
  end

end
