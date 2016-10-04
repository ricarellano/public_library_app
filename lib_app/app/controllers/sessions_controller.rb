class SessionsController < ApplicationController

  # display login form
  def new
    @user = User.new
    render :new
  end

  # process login form data & create new session
  def create
    user_params = params.require(:user).permit(:email, :password)
    @user = User.confirm(user_params)
    if @user
      login(@user)
      flash[:notice] = "Successfully logged in."
      redirect_to @user
    else
      flash[:error] = "Incorrect email or password."
      redirect_to login_path
    end
  end

  # logout current user
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Successfully logged out."
    redirect_to root_path
  end

end