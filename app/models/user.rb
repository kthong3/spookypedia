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
    self.articles.select { |article| article.is_published == true }
  end

  def unpublished_articles
    self.articles.select { |article| article.is_published == false }
  end

  def is_admin?
    self.is_admin == true
  end
end
