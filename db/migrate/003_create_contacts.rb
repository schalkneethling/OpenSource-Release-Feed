class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.column :name, :string
      t.column :email, :string
      t.column :message, :text
      t.column :user_ip, :string
      t.column :user_agent, :string
      t.column :referrer, :string
      t.column :approved, :boolean, :default => false, :null => false
    end
  end

  def self.down
    drop_table :contacts
  end
end
