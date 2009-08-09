class Release < ActiveRecord::Base
  
  before_create :generate_permalink
  
  validates_presence_of :name, :release_date, :details, :download_url, :releasenotes_url, :tags
  
  belongs_to :user
  has_many :votes
  has_many :comments
  
  def self.fetch_latest_releases(conditions, page)
    paginate :per_page => 10, :page => page,
             :select => "id, name, (select left(details, 200)) AS details, release_date, permalink",
             :conditions => conditions,
             :order => 'release_date DESC'
  end
  
  def self.fetch_archived_releases(conditions, page)
    paginate :per_page => 10, :page => page,
             :select => "id, name, (select left(details, 200)) AS details, release_date, permalink",
             :conditions => conditions,
             :order => 'release_date DESC'
  end
  
  def self.fetch_active_releases(conditions, page)
    paginate :per_page => 30, :page => page,
             :select => "id, name, permalink",
             :conditions => conditions,
             :order => 'id DESC'
  end
  
  protected
  def generate_permalink
    self.permalink = name.downcase.gsub(/\W/, '-')
  end
end