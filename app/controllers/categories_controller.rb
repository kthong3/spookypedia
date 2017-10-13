class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    @featured_article = Article.random_article
  end

  def new
    authenticate!
    @user = current_user
    render :file => "#{Rails.root}/public/404.html", :status => 404 and return unless @user.is_admin?
  end

  def create
    authenticate!
    @user = current_user
    render :file => "#{Rails.root}/public/404.html", :status => 404 and return unless @user.is_admin?

    category = Category.new(post_params)

    if category.save
      redirect_to category_url(category), notice: "Category successfully created!"
    else
      @errors = category.errors.full_messages
      render "categories/new"
    end
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.published
    @featured = @articles.sample
  end

  def destroy
  end

  def post_params
    params.require(:category).permit(:name)
  end
end
