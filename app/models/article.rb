class Article < ActiveRecord::Base
  
  before_create :generate_permalink
  
  validates_presence_of :title, :lead, :detail, :tag, :photo
  
  has_many :comments
  
  def self.fetch_articles(page)
    paginate :per_page => 5, :page => page,
             :select => "title, lead, photo, permalink",
             :conditions => 'status = "active"',
             :order => 'id DESC'
  end
  
  def self.fetch_bookreviews(page)
    paginate :per_page => 5, :page => page,
             :select => "title, lead, photo, permalink",
             :conditions => 'status = "active" and article_type = "book-review"',
             :order => 'id DESC'
  end
  
   def self.fetch_community_reviews(page)
    paginate :per_page => 5, :page => page,
             :select => "title, lead, photo, permalink",
             :conditions => 'status = "active" and article_type = "community-review"',
             :order => 'id DESC'
  end
  
  def upload_article(newArticle, status)
    
    #Mandatory elements
    write_attribute("title", newArticle.fetch('title'))
    write_attribute("lead", newArticle.fetch('lead'))
    write_attribute("detail", newArticle.fetch('detail'))    
    write_attribute("tag", newArticle.fetch('tag'))
    write_attribute("status", status)
    
    @photo = newArticle.fetch('photo')
    self.upload_photo = @photo.original_filename
    
  end
  
  def upload_photo=(article_photo)
    File.open("#{RAILS_ROOT}/public/images/article_images/#{sanitize_filename(article_photo)}", "wb") do |f| 
        f.write(@photo.read)
    end
    update_attribute("photo", sanitize_filename(article_photo))
  end
  
  protected
  def generate_permalink
    self.permalink = title.downcase.gsub(/\W/, '-')
  end
  
  private
  def sanitize_filename(filename)
    # get only the filename, not the whole path (from IE)
    just_filename = File.basename(filename)
    # replace all non-alphanumeric, underscore or periods with underscores
    just_filename.gsub(/[^\w\.\-]/,'_')
  end
end