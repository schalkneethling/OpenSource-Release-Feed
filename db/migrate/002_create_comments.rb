class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :name, :string
      t.column :email, :string
      t.column :website, :string
      t.column :user_ip, :string
      t.column :user_agent, :string
      t.column :referrer, :string
      t.column :approved, :boolean, :default => false, :null => false
      t.column :comment, :text
    end
  end

  def self.down
    drop_table :comments
  end
end
