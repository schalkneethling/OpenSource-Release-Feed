class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.column :news_url, :string
      t.column :headline, :string
      t.column :description, :text
      t.column :tags, :string
      t.column :user_id, :integer
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :news
  end
end
