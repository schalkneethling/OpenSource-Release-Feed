class AddNameToInterviews < ActiveRecord::Migration
  def self.up
    add_column :interviews, :name, :string
  end

  def self.down
    remove_column :interviews, :name
  end
end
