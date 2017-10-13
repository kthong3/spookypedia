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
        redirect_to article_url(params[:article_id]), alert: "Comment cannot be blank!"
      end
    end
  end

  def update
    comment = find_and_ensure_comment(params[:id])
    @article = comment.article
    if params[:commit] == "Flag"
      comment.update(is_flagged: true)
    elsif params[:commit] == "Flagged" && current_user.is_admin?
      comment.update(is_flagged: false)
    end
    render 'articles/show'
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end


  def find_and_ensure_comment(id)
    comment = Comment.find_by(id: id)
    render :file => "#{Rails.root}/public/404.html", :status => 404 unless comment
    comment
  end
end
