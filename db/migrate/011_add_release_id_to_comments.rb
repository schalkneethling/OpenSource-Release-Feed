class AddReleaseIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :release_id, :integer
  end

  def self.down
    remove_column :comments, :release_id
  end
end
