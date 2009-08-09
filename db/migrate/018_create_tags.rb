class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.column :tag, :string
      t.column :release_id, :integer
    end
  end

  def self.down
    drop_table :tags
  end
end
