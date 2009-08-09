class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.column :event_url, :string
      t.column :event_date, :date
      t.column :headline, :string
      t.column :description, :text
      t.column :tags, :string
      t.column :user_id, :integer
      t.column :permalink, :string
      t.column :status, :string
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :events
  end
end
