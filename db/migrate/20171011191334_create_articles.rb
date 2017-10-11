class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.integer   :category_id
      t.integer   :author_id
      t.string    :title
      t.text      :body
      t.boolean   :is_flagged
      t.boolean   :is_published

      t.timestamps
    end
  end
end
