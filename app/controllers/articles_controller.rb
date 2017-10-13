class ArticlesController < ApplicationController

  def index
    if params[:search]
      @articles = Article.search(params[:search])
      render "articles/index"
    else
      redirect_to categories_url
    end
  end

  def new
    authenticate!
    category_array = []
    Category.all.each { |category| category_array << [category.name, category.id] }
    @category = category_array
    @article = Article.new(category_id: params[:cat_id], title: "", body: "")
  end

  def create
    authenticate!
    article = Article.new(post_params)
    article.author_id = current_user.id
    if article.save
      if article.is_published
        redirect_to article_url(article), notice: "Article successfully created and published!"
      else
        redirect_to user_url(current_user), notice: "Article successfully created and saved as a draft!"
      end
    else
      @errors = article.errors.full_messages
      category_array = []
      Category.all.each { |category| category_array << [category.name, category.id] }
      @category = category_array
      @article = article
      render "articles/new"
    end
  end

  def show
    @article = find_and_ensure_article(params[:id])
  end

  def edit
    authenticate!

    @article = find_and_ensure_article(params[:id])

    category_array = []
    Category.all.each { |category| category_array << [category.name, category.id] }
    @category = category_array
  end

  def update
    @article = find_and_ensure_article(params[:id])
    if params[:commit] == "Flag"
      @article.update(is_flagged: true)
      render 'articles/show' and return
    elsif params[:commit] == "Flagged" && current_user.is_admin?
      @article.update(is_flagged: false)
      render 'articles/show' and return
    end

    authenticate!

    @article.editor = current_user

    if @article.update(post_params)
      redirect_to article_url(@article), notice: "Article successfully edited!"
    else
      @errors = @article.errors.full_messages
      @article = find_and_ensure_article(params[:id])
      category_array = []
      Category.all.each { |category| category_array << [category.name, category.id] }
      @category = category_array
      render "articles/edit"
    end
  end



  def destroy
    @article = find_and_ensure_article(params[:id])
    @article.comments.destroy_all
    Article.destroy(@article.id)
    redirect_to "/categories", alert: "Article deleted!!!"
  end

  def find_and_ensure_article(id)
    article = Article.find_by(id: id)
    render :file => "#{Rails.root}/public/404.html", :status => 404 unless article && (article.is_published == true || authorized?(article.author))
    article
  end

  def post_params
    params.require(:article).permit(:category_id, :title, :body, :is_published)
  end

end
