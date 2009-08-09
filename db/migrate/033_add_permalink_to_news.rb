class AddPermalinkToNews < ActiveRecord::Migration
  def self.up
    add_column :news, :permalink, :string
  end

  def self.down
    remove_column :news, :permalink
  end
end
