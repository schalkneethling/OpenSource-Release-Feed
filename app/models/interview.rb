class Interview < ActiveRecord::Base
  
  before_create :generate_permalink
  
  validates_presence_of :name, :title, :interview, :tag, :photo
  
  has_many :comments
  
  def self.fetch_interviews(page)
    paginate :per_page => 5, :page => page,
             :select => "title, name, lead, photo, permalink",
             :order => 'id DESC'
  end
  
  def self.fetch_active_interviews(conditions, page)
    paginate :per_page => 20, :page => page,
             :select => "id, title",
             :conditions => conditions,
             :order => 'id DESC'
  end
  
  def self.fetch_draft_interviews(conditions, page)
    paginate :per_page => 20, :page => page,
             :select => "id, title",
             :conditions => conditions,
             :order => 'id DESC'
  end
  
  def upload_interview=(newInterview)
    
    #Mandatory elements
    write_attribute("name", newInterview.fetch('name'))
    write_attribute("title", newInterview.fetch('title'))
    write_attribute("lead", newInterview.fetch('lead'))
    write_attribute("interview", newInterview.fetch('interview'))    
    write_attribute("tag", newInterview.fetch('tag'))
    
    @photo = newInterview.fetch('photo')
    self.upload_photo = @photo.original_filename
    
  end
  
  def upload_photo=(interview_photo)
    File.open("#{RAILS_ROOT}/public/images/photos/#{sanitize_filename(interview_photo)}", "wb") do |f| 
        f.write(@photo.read)
    end
    update_attribute("photo", sanitize_filename(interview_photo))
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