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
  end

  private

  def post_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def find_and_ensure_user(id)
    user = User.find_by(id: id)
    render :file => "#{Rails.root}/public/404.html", :status => 404 unless user
    user
  end

end


