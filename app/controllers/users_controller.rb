class UsersController < ApplicationController
  def index
  end

  def new
  end

  def create
    user = User.new(post_params)
    if user.save
      redirect_to new_session_url
    else
      @errors = user.errors.full_messages
      render "users/new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

  def post_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
