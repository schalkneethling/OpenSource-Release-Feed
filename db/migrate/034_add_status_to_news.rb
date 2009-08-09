class AddStatusToNews < ActiveRecord::Migration
  def self.up
    add_column :news, :status, :string
  end

  def self.down
    remove_column :news, :status
  end
end
