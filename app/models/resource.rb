class Resource < ActiveRecord::Base
  before_create :generate_permalink
  
  validates_presence_of :title, :lead, :detail, :tag, :photo
  
  has_many :comments
  
  def self.fetch_resources(page)
    paginate :per_page => 5, :page => page,
             :select => "title, lead, photo, permalink",
             :order => 'id DESC'
  end
  
  def upload_resource=(newResource)
    
    #Mandatory elements
    write_attribute("title", newResource.fetch('title'))
    write_attribute("lead", newResource.fetch('lead'))
    write_attribute("detail", newResource.fetch('detail'))    
    write_attribute("tag", newResource.fetch('tag'))
    
    @photo = newResource.fetch('photo')
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