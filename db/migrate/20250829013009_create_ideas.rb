class CreateIdeas < ActiveRecord::Migration[7.2]
  def change
    create_table :ideas do |t|
      t.uuid :user_uuid, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.text :priority_emoji
      t.boolean :is_public, default: false, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
