class Category < ApplicationRecord
  has_many :articles
  has_many :contributors, through: :articles, source: :author
  has_many :comments, through: :articles

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
