class AddStatusToInterviews < ActiveRecord::Migration
  def self.up
    add_column :interviews, :status, :string
  end

  def self.down
    remove_column :interviews, :status
  end
end
