class SessionsController < ApplicationController


  def create

    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'You have successfully logged in.'
      redirect_to root_path
    else
      flash[:danger] = 'The username or password you entered is incorrect.'
      redirect_to :back
    end

  end

  def destroy
    if logged_in?
      session[:user_id] = nil
      flash[:info] = 'You have logged out.'
    end
    redirect_to root_path
  end

  def welcome
    render 'shared/welcome'
  end

end
