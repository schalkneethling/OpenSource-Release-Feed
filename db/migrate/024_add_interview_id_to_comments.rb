class AddInterviewIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :interview_id, :integer
  end

  def self.down
    remove_column :comments, :interview_id
  end
end
