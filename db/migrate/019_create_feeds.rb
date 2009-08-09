class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.column :tags, :string
      t.column :release_types, :string
      t.column :feedburner, :string
      t.column :localfeed, :string
      t.column :user_id, :integer
      t.column :status, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :feeds
  end
end
