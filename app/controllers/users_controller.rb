class UsersController < ApplicationController

  before_action :set_user, except: [:new, :create]

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

  private

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit!
  end

end
