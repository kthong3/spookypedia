class UsersController < ApplicationController
  def index
  end

  def new
  end

  def create
    user = User.new(post_params)
    if user.save
      session[:user_id] = user.id
      redirect_to categories_url
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


