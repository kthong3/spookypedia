class User < ApplicationRecord
  has_many :articles, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :active_categories, through: :articles, source: :category
  has_many :revisions, foreign_key: :editor_id

  after_initialize :init

  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def init
    self.is_admin ||= false
    self.is_banned ||= false
    self.bio ||= "Apparently, this user prefers to keep an air of mystery about them"
  end

  def published_articles
    self.articles.published
  end

  def unpublished_articles
    self.articles.unpublished
  end

  def is_admin?
    self.is_admin == true
  end

  def self.article_search(search)
    authors = self.where("username LIKE ?", "%#{search}%")
    return authors if authors.count == 0
    articles = authors[0].articles.published
    return articles if authors.count == 1
    index = 1
    while index < authors.count
      next_articles = authors[index].articles.published
      articles += next_articles
      index += 1
    end
    articles
  end
end
