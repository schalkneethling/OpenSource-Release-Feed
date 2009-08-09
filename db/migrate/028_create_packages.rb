class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.column :title, :string
      t.column :lead, :text
      t.column :detail, :text
      t.column :logo, :string
      t.column :download, :string
      t.column :tag, :string
      t.column :permalink, :string
    end
  end

  def self.down
    drop_table :packages
  end
end
