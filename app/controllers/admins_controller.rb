class AdminsController < ApplicationController
  def index
    authenticate!
    @user = find_and_ensure_user(params[:user_id])
    render :file => "#{Rails.root}/public/404.html", :status => 404 and return unless @user.is_admin?
    @articles = Article.flagged_articles
    @comments = Comment.flagged_comments
  end

  def new

  end

  def create

  end

  def destroy

  end


  def find_and_ensure_user(id)
    user = User.find_by(id: id)
    render :file => "#{Rails.root}/public/404.html", :status => 404 unless user
    user
  end

end
