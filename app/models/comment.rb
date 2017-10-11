class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :article
  has_one :category, through: :article
end
