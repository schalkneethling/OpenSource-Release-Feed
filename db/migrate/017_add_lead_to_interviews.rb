class AddLeadToInterviews < ActiveRecord::Migration
  def self.up
    add_column :interviews, :lead, :text
  end

  def self.down
    remove_column :interviews, :lead
  end
end
