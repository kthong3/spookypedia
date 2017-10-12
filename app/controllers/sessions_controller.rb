class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if !@user.nil? && !!@user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to "/categories"
    else
      @user = User.new(email: params[:user][:email])
      @error = true
      render "/sessions/new"
    end
  end

  def destroy
    reset_session
    redirect_to "/categories"
  end

end
