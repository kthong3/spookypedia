class RevisionsController < ApplicationController

  def index
    authenticate!
    @article = Article.find(params[:article_id])
    if authorized?(@article.author)
      @revisions = @article.revisions.order("created_at DESC")
      render 'index'
    end
  end

  def create
  end
end