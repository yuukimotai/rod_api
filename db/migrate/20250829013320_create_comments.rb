class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.uuid :uuid
      t.text :content
      t.string :emotions
      t.integer :parent_id, index: true
      t.references :user, null: false, foreign_key: true
      t.references :idea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
