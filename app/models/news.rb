class News < ActiveRecord::Base
  
  before_create :generate_permalink
  
  validates_presence_of :news_url, :headline, :description, :tags
  
  belongs_to :user
  has_many :comments
  
  def self.fetch_latest_news(conditions, page)
    paginate :per_page => 10, :page => page,
             :select => "id, user_id, (select left(description, 100)) AS description, created_at, headline, permalink, tags, news_url",
             :conditions => conditions,
             :order => 'id DESC'
  end
  
  protected
  def generate_permalink
    self.permalink = headline.downcase.gsub(/\W/, '-')
  end
end
