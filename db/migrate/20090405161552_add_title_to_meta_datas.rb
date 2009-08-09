class AddTitleToMetaDatas < ActiveRecord::Migration
  def self.up
    add_column :meta_datas, :title, :string
  end

  def self.down
    remove_column :meta_datas, :title
  end
end
