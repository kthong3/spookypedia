class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    @featured_article = Article.random_article
  end

  def new
  end

  def create
  end

  def show
    @category = Category.find(params[:id])
    @articles = Article.where(category_id: @category.id)
    @featured = @articles.sample
  end

  def destroy
  end
end
