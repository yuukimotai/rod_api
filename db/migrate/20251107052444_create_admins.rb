class CreateAdmins < ActiveRecord::Migration[7.2]
  def change
    create_table :admins do |t|
      t.uuid :uuid, null: false, default: 'gen_random_uuid()'
      t.citext :email, null: false
      t.check_constraint "email ~ '^[^,;@ \r\n]+@[^,@; \r\n]+\.[^,@; \r\n]+$'", name: "valid_email"
      t.string :password_hash
      t.timestamps
    end
  end
end
