class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :genre_id
      t.integer :customer_id
      t.text :introduction

      t.timestamps
    end
  end
end
