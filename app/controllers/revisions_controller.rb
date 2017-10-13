class RevisionsController < ApplicationController

  def index
    authenticate!
    @article = Article.find(params[:article_id])
    # if authorized?(@article.author) # to do: || ADMIN USER
    @revisions = @article.revisions.order("created_at DESC")
      # render 'index'
    # else
    #   redirect_to article_path(@article), notice: "You are not the author of this article!"
    # end
  end

  def revise
    authenticate!
    @article = Article.find(params[:article_id])
    @article.editor = current_user
    @revision = Revision.find(params[:id])
    if current_user.is_admin? || authorized?(@article.author)
      @article.rollback!(@revision)
    end
    redirect_to article_path(@article)
  end

end
