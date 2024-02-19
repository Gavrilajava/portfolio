class CreateUrls < ActiveRecord::Migration[7.1]
  def up
    create_table :urls do |t|
      t.string :long
      t.string :short

      t.timestamps
    end
    add_index :urls, :short, unique: true
    add_index :urls, :long, unique: true
    sql = File.read("#{Rails.root}/db/triggers/add_unique_short_to_urls_on_insert.sql")
    ActiveRecord::Base.connection.execute sql
  end

  def down
    drop_table :urls
    ActiveRecord::Base.connection.execute 'DROP FUNCTION IF EXISTS add_unique_short'
  end
end
