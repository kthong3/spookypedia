class Category < ApplicationRecord
  has_many :articles
  has_many :contributors, through: :articles, source: :author
  has_many :comments, through: :articles

  def top_articles
    articles.select { |article| (article.comments.count > 2) }
  end

  def sample_articles
    articles.sample(rand(2..4))
  end

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def self.article_search(search)
    cap_search = search.capitalize
    categories = self.where("name LIKE ?", "%#{cap_search}%")
    return categories if categories.count == 0
    articles = categories[0].articles.published
    return articles if categories.count == 1
    index = 1
    while index < categories.count
      next_articles = categories[index].articles.published
      articles += next_articles
      index += 1
    end
    articles
  end
end
