class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.references :posts, null: false, foreign_key: true
      t.string :emotions
      t.text :content

      t.timestamps
    end
  end
end
