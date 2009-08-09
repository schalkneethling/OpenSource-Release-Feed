class AddWebsiteToReleases < ActiveRecord::Migration
  def self.up
    add_column :releases, :website, :string
  end

  def self.down
    remove_column :releases, :website
  end
end
