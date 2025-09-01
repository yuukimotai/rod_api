class CreateRodauthOtpRecoveryCodes < ActiveRecord::Migration[7.2]
  def change
    # Used by the otp feature
    create_table :account_otp_keys, id: false do |t|
      t.bigint :id, primary_key: true
      t.foreign_key :users, column: :id
      t.string :key, null: false
      t.integer :num_failures, null: false, default: 0
      t.datetime :last_use, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end

    # Used by the recovery codes feature
    create_table :account_recovery_codes, primary_key: [:id, :code] do |t|
      t.bigint :id
      t.foreign_key :users, column: :id
      t.string :code
    end
  end
end
