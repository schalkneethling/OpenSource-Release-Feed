class AddPermalinkToInterviews < ActiveRecord::Migration
  def self.up
    add_column :interviews, :permalink, :string
  end

  def self.down
    remove_column :interviews, :permalink
  end
end
