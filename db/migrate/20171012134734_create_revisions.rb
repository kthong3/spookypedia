class CreateRevisions < ActiveRecord::Migration[5.1]
  def change
    create_table :revisions do |t|
      t.integer :object_id
      t.string :revised_attribute
      t.string :before_value
      t.string :revised_value
      t.integer :editor_id

      t.timestamps
    end
  end
end
