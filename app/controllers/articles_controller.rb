class ArticlesController < ApplicationController

  def index
  end

  def new
  end

  def create
  end

  def show
    @article = find_and_ensure_article(params[:id])
  end

  def edit
  end

  def update
    @editor = current_user
  end

  def destroy
  end

  def find_and_ensure_article(id)
    article = Article.find_by(id: id)
    render :file => "#{Rails.root}/public/404.html", :status => 404 unless article && article.is_published == true
    article
  end

end

