class Package < ActiveRecord::Base
  before_create :generate_permalink
  
  validates_presence_of :title, :lead, :detail, :tag, :logo
  
  has_many :comments
  
  def self.fetch_packages(page)
    paginate :per_page => 5, :page => page,
             :select => "title, lead, logo, permalink",
             :order => 'id DESC'
  end
  
  def upload_package=(newPackage)
    
    #Mandatory elements
    write_attribute("title", newPackage.fetch('title'))
    write_attribute("lead", newPackage.fetch('lead'))
    write_attribute("detail", newPackage.fetch('detail'))    
    write_attribute("tag", newPackage.fetch('tag'))
    
    @logo = newPackage.fetch('logo')
    self.upload_logo = @logo.original_filename
    
    @download = newPackage.fetch('download')
    self.add_package = @download.original_filename    
  end
  
  def upload_logo=(package_logo)
    File.open("#{RAILS_ROOT}/public/images/article_images/#{sanitize_filename(package_logo)}", "wb") do |f| 
        f.write(@logo.read)
    end
    update_attribute("logo", sanitize_filename(package_logo))
  end
  
  def add_package=(package)
    File.open("#{RAILS_ROOT}/public/packageit/#{sanitize_filename(package)}", "wb") do |f| 
        f.write(@download.read)
    end
    update_attribute("download", sanitize_filename(package))
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