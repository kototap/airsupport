class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :tag_id
      t.string :title
      t.string :body
      t.string :airport
      t.boolean :is_draft, default: false

      t.timestamps
    end
  end
end
