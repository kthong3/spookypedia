class User < ApplicationRecord
  has_many :articles, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :active_categories, through: :articles, source: :category
  after_initialize :init

  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def init
    self.is_admin ||= false
    self.is_banned ||= false
  end
end
