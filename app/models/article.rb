include ActiveModel::Dirty

class Article < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :category
  has_many :comments
  has_many :revisions, foreign_key: :object_id

  validates :title, presence: true
  validates :body, presence: true

  after_initialize :init

  before_update :log_revision

  def self.random_article
    # self.order("RANDOM()").first
    self.published.sample
  end

  def editor
    @editor
  end

  def editor=(editor)
    @editor = editor
  end

  def init
    self.is_flagged ||= false
    self.is_published ||= false
  end

  def rollback!(revision)
    if revision.revised_attribute == "title"
      self.title = revision.before_value
    elsif revision.revised_attribute == "body"
      self.body = revision.before_value
    end
    self.save
  end



  private


  def self.flagged_articles
    select { |article| article.is_flagged == true }
  end

  def self.published
    select { |article| article.is_published == true }
  end

  def self.unpublished
    select { |article| article.is_published == false }
  end

  def log_revision
    self.changes.each do |revised_attribute, values|
      if revised_attribute == "body" || revised_attribute == "title"
        before_value = values[0]
        revised_value = values[1]
        editor_id = editor.id
        Revision.create!(object_id: self.id, revised_attribute: revised_attribute, before_value: before_value, revised_value: revised_value, editor_id: editor_id)
      end
    end
  end

  def self.search(search)
    article_search = self.where("title LIKE ? OR body LIKE ?", "%#{search}%", "%#{search}%")
    category_articles = Category.article_search(search)
    if article_search.count > 0 && category_articles.count > 0
      article_search = article_search.or(category_articles)
    elsif article_search.empty?
      article_search = category_articles
    end
    user_articles = User.article_search(search)
    if article_search.count > 0 && user_articles.count > 0
      article_search.or(user_articles) if user_articles.count > 0
    elsif article_search.empty?
      article_search = user_articles
    end
    article_search
  end

end
