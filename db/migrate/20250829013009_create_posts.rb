class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.uuid :uuid, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.text :priority_emoji
      t.boolean :is_public, default: false, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
