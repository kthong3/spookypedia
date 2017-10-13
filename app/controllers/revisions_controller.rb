class RevisionsController < ApplicationController

  def index
    authenticate!
    @article = Article.find(params[:article_id])
    if authorized?(@article.author) # to do: || ADMIN USER
      @revisions = @article.revisions.order("created_at DESC")
      render 'index'
    end
  end

  def create
  end

  def revise
    authenticate!
    @article = Article.find(params[:article_id])
    @article.editor = current_user
    @revision = Revision.find(params[:id])
    if authorized?(@article.author)
      @article.rollback!(@revision)
    end
    redirect_to article_path(@article)
  end

end