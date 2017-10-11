class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer   :article_id
      t.integer   :author_id
      t.text      :body
      t.boolean   :is_flagged

      t.timestamps
    end
  end
end
