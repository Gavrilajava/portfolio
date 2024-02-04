# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def up
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.string :name, null: false, default: ''
      t.integer :role, null: false, default: 0

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true

    User.create!(Rails.application.credentials.superuser.to_h)
  end

  def down
    drop_table :users
  end
end
