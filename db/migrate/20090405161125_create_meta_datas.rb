class CreateMetaDatas < ActiveRecord::Migration
  def self.up
    create_table :meta_datas do |t|
      t.column :page, :string
      t.column :description, :string
      t.column :keywords, :string
    end
  end

  def self.down
    drop_table :meta_datas
  end
end
