class AddCounterCacheToReleases < ActiveRecord::Migration
  def self.up
    add_column :releases, :votes_count, :integer, :default => 0
    Release.find(:all).each do |e|
      e.update_attribute :votes_count, e.votes.length
    end
  end

  def self.down
    remove_column :events, :votes_count
  end
end
