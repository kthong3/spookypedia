class Revision < ApplicationRecord
  belongs_to :object, class_name: "Article", foreign_key: :object_id
  belongs_to :editor, class_name: "User", foreign_key: :editor_id
end