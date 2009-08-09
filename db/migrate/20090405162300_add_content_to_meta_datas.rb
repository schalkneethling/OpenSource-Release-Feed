class AddContentToMetaDatas < ActiveRecord::Migration
  def self.up
    add_column :meta_datas, :content, :text
  end

  def self.down
    remove_column :meta_datas, :content
  end
end
