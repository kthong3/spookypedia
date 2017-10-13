class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string  :username
      t.string  :email
      t.string  :password_digest
      t.string  :profile_pic_url
      t.boolean :is_admin
      t.boolean :is_banned
      t.text    :bio

      t.timestamps
    end
  end
end
