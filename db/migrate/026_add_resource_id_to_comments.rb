class AddResourceIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :resource_id, :integer
  end

  def self.down
    remove_column :comments, :resource_id
  end
end
