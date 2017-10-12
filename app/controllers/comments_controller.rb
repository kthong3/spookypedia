class CommentsController < ApplicationController

  def create
    comment = Comment.new(comment_params)
    comment.article_id = params[:article_id]
    comment.author_id = current_user.id
    if comment.save
      redirect_to article_url(params[:article_id])
    else
      if Article.find_by(id: params[:article_id]).nil? || Article.find_by(id: params[:article_id]).is_published == false
        render :file => "#{Rails.root}/public/404.html", :status => 404
      else
        redirect_to article_url(params[:article_id]), notice: "Comment cannot be blank!"
      end
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
