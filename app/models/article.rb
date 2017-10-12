include ActiveModel::Dirty

class Article < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :category
  has_many :comments
  has_many :revisions, foreign_key: :object_id

  validates :title, presence: true
  validates :body, presence: true

  after_initialize :init

  before_update do
    log_revision(editor)
  end

  def init
    self.is_flagged ||= false
    self.is_published ||= false
  end

  private

  def log_revision(editor)
    self.changes.each do |revised_attribute, values|
      before_value = values[0]
      revised_value = values[1]
      editor_id = editor.id
      Revision.create!(object_id: self.id, revised_attribute: revised_attribute, before_value: before_value, revised_value: revised_value, editor_id: editor_id)
    end
  end

  def rollback

  end


end
