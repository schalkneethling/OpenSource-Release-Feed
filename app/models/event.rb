class Event < ActiveRecord::Base
  
  before_create :generate_permalink
  
  validates_presence_of :event_url, :event_date, :headline, :description, :tags
  
  belongs_to :user
  has_many :comments
  
  def self.fetch_latest_events(conditions, page)
    paginate :per_page => 10, :page => page,
             :select => "id, user_id, (select left(description, 100)) AS description, event_date, headline, permalink, tags, event_url",
             :conditions => conditions,
             :order => 'event_date DESC'
  end
  
  protected
  def generate_permalink
    self.permalink = headline.downcase.gsub(/\W/, '-')
  end
end
