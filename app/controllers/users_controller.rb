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
    @user = User.find(params[:id])
    authorize!(@user)
    p "************"
    p "EDIT!!!!!!!"

    if @user.update(post_params)
      redirect_to user_url(@user), notice: "User bio successfully edited!"
    else
      @errors = @article.errors.full_messages

      render "users/show"
    end

  end

  private

  def post_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :bio)
  end

end


