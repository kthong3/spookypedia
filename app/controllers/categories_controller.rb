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
    @articles = @category.articles.published
    @featured = @articles.sample
  end

  def destroy
  end
end
