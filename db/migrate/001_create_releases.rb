class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.column :name, :string
      t.column :details, :text
      t.column :download_url, :string
      t.column :releasenotes_url, :string
      t.column :tags, :string
      t.column :release_type, :string
      t.column :logo, :string
      t.column :icon, :string
      t.column :user_id, :integer
      t.column :created_at, :date
    end
  end

  def self.down
    drop_table :releases
  end
end
