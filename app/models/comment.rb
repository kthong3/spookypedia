class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :article
  has_one :category, through: :article

  after_initialize :init

  validates :body, presence: true

  def init
    self.is_flagged ||= false
  end

  def self.flagged_comments
    self.select { |comment| comment.is_flagged == true }
  end

end
