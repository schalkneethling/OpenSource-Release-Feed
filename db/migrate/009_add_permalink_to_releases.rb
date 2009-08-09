class AddPermalinkToReleases < ActiveRecord::Migration
  def self.up
    add_column :releases, :permalink, :string
  end

  def self.down
    remove_column :releases, :permalink
  end
end