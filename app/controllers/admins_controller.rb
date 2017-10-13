class AdminsController < ApplicationController
  def index
    authenticate!
    @user = find_and_ensure_user(params[:user_id])
    render :file => "#{Rails.root}/public/404.html", :status => 404 and return unless @user.is_admin?
    @articles = Article.flagged_articles
    @comments = Comment.flagged_comments

    user_array = []
    not_admins = User.not_admins
    not_admins.each { |user| user_array << [user.username, user.id] }
    @user_array = user_array
    @admins = User.admins
  end

  def new

  end

  def create
    user = User.find_by(id: params[:user][:id])
    user.update(is_admin: true)
    redirect_to user_admins_url, notice: "New admin appointed!"
  end

  def destroy

  end


  def find_and_ensure_user(id)
    user = User.find_by(id: id)
    render :file => "#{Rails.root}/public/404.html", :status => 404 unless user
    user
  end

end
