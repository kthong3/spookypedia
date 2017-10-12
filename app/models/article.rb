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
  end

  private

  def log_revision
    self.changes.each do |revised_attribute, values|
      if revised_attribute != "updated_at"
        before_value = values[0]
        revised_value = values[1]
        editor_id = editor.id
        Revision.create!(object_id: self.id, revised_attribute: revised_attribute, before_value: before_value, revised_value: revised_value, editor_id: editor_id)
      end
    end
  end

end
