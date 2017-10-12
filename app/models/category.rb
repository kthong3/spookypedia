class Category < ApplicationRecord
  has_many :articles
  has_many :contributors, through: :articles, source: :author
  has_many :comments, through: :articles

  def top_articles
    self.articles.select { |article| (article.comments.count > 2) }
  end

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
