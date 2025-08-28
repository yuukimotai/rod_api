class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.uuid :uuid, null: false
      t.integer :post_number, null: false
      t.string :title
      t.text :content
      t.string :priority_emoji
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
