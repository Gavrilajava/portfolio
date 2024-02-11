class CreateContactRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :contact_requests do |t|
      t.string :email
      t.text :message
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :contact_requests, :status
  end
end
