class CreateInterviews < ActiveRecord::Migration
  def self.up
    create_table :interviews do |t|
      t.column :title, :string
      t.column :interview, :text
      t.column :photo, :string
      t.column :tag, :string
    end
  end

  def self.down
    drop_table :interviews
  end
end
