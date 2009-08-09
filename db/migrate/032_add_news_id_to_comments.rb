class AddNewsIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :news_id, :integer
  end

  def self.down
    remove_column :comments, :news_id
  end
end
