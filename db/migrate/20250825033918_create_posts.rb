class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.uuid :uuid, null: false
      t.bigint :post_number, null: false
      t.string :title, null: false
      t.text :content

      t.timestamps
    end
  end
end
