class AddPackageIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :package_id, :integer
  end

  def self.down
    remove_column :comments, :package_id
  end
end
