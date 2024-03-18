# frozen_string_literal: true

class CreateRodauthWebauthn < ActiveRecord::Migration[7.1] # :nodoc:
  def change
    # Used by the webauthn feature
    # rubocop:disable Rails/DangerousColumnNames
    create_table :account_webauthn_user_ids, id: false do |t|
      t.bigint :id, primary_key: true
      t.foreign_key :accounts, column: :id
      t.string :webauthn_id, null: false
    end
    # rubocop:enable Rails/DangerousColumnNames

    create_table :account_webauthn_keys, primary_key: %i[account_id webauthn_id] do |t| # rubocop:disable Rails/CreateTableWithTimestamps
      t.references :account, foreign_key: true
      t.string :webauthn_id
      t.string :public_key, null: false
      t.integer :sign_count, null: false
      t.datetime :last_use, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end
  end
end
