class UsersController < ApplicationController
  def index
  end

  def new
  end

  def create
    user = User.new(post_params)
    if user.save
      session[:user_id] = user.id
      redirect_to categories_url, notice: "Thanks for registering! Enjoy your stay!"
    else
      @errors = user.errors.full_messages
      render "users/new"
    end
  end

  def show
    @user = find_and_ensure_user(params[:id])
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    authorize!(@user)

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

  def find_and_ensure_user(id)
    user = User.find_by(id: id)
    render :file => "#{Rails.root}/public/404.html", :status => 404 unless user
    user
  end

end


