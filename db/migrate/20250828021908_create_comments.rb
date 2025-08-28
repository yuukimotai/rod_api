class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.uuid :uuid, null: false
      t.string :title
      t.text :content
      t.string :emotions
      t.references :post, null: false, foreign_key: true
      t.references :parent, foreign_key: { to_table: :comments }
      t.timestamps
    end
  end
end
