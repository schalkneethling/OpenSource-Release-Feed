class AddStatusToReleases < ActiveRecord::Migration
  def self.up
    add_column :releases, :status, :string
  end

  def self.down
    remove_column :releases, :status
  end
end
