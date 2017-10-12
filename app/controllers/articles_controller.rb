class ArticlesController < ApplicationController

  def index
  end

  def new
    category_array = []
    Category.all.each { |category| category_array << [category.name, category.id] }
    @category = category_array
  end

  def create
    p "******************"
    p "Category is: #{post_params[:category_id]}"
    p "Title is: #{post_params[:title]}"
    p "Body is: #{post_params[:body]}"
    p "Publish? is: #{post_params[:is_published]}"

    article = Article.new(post_params)
    article.author_id = current_user.id
    if article.save
      redirect_to article_url(article)
    else
      @errors = article.errors.full_messages
      category_array = []
      Category.all.each { |category| category_array << [category.name, category.id] }
      @category = category_array
      render "articles/new"
    end

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
    params.require(:article).permit(:category_id, :title, :body, :is_published)
  end

end

