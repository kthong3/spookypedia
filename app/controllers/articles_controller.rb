class ArticlesController < ApplicationController

  def index
  end

  def new
    @categories = Category.all
    p "Categories array is: #{@categories}"
    p "******************"
  end

  def create
    p "******************"
    p "Category is: #{post_params[:test_category]}"
    p "Title is: #{post_params[:title]}"
    p "Body is: #{post_params[:body]}"

  end

  def show
    @article = find_and_ensure_article(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def find_and_ensure_article(id)
    article = Article.find_by(id: id)
    render :file => "#{Rails.root}/public/404.html", :status => 404 unless article && article.is_published == true
    article
  end

  def post_params
    params.require(:article).permit(:new_article_category, :test_category, :title, :body)
  end

end

