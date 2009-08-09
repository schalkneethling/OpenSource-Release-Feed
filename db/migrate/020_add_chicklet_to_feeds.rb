class AddChickletToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :chicklet, :string
  end

  def self.down
    remove_column :feeds, :chicklet
  end
end
