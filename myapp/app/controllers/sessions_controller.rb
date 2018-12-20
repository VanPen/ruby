class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user  && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have logged in"
      redirect_to user_path(user)
    else
      render 'new'
    end
  end
  def destroy
    session.delete(:user_id)
    flash[:success] = "You have logged out"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end