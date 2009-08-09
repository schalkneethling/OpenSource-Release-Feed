class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.column :title, :string
      t.column :lead, :text
      t.column :detail, :text
      t.column :photo, :string
      t.column :tag, :string
      t.column :permalink, :string
    end
  end

  def self.down
    drop_table :articles
  end
end
