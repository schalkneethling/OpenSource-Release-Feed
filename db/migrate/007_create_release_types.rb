class CreateReleaseTypes < ActiveRecord::Migration
  def self.up
    create_table :release_types do |t|
      t.column :release_type, :string
    end
  end

  def self.down
    drop_table :release_types
  end
end
