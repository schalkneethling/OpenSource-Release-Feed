class ReleaseController < ApplicationController
  
  before_filter :login_required, :only => [:new]
  
  def index
    @metadata = get_metadata('home')
    
    from = Date.today - 14
    to = Date.today    
    
    @releases = Release.fetch_latest_releases(["status = 'active' and release_date BETWEEN ? and ?", from, to], params[:page])    
    @date_range = "Since " + from.strftime("%d %B %Y")
    
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    
    render :layout => 'frontpage'
  end
  
  def archive
    @metadata = get_metadata('home')
    @title = "Release Archive : "
    @description = 'OpenSource Release Feed Archive'
    
    month = Date.today.strftime('%m')
    year = Date.today.strftime('%Y')
    
    @releases = Release.fetch_archived_releases("status = 'active' and (YEAR(release_date) < " + year + " or MONTH(release_date) < " + month + ")", params[:page])
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    render :layout => 'release_view'
  end
  
  def manning
    @metadata = get_metadata('manning')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
  end  
  
  def new
    @metadata = get_metadata('new')
    @release_types = ReleaseTypes.find(:all)
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    
    if request.post?
      @newRelease = Release.new(params[:release])
      @newRelease.user = @current_user
      @newRelease.status = 'moderating'
      @newRelease.save
      
      Notifier.deliver_new_release_alert(@newRelease)
      Notifier.deliver_acknowledge_new_release_submission(@newRelease, @current_user)
      
      flash[:notice] = 'Release notification submitted for moderation. Thank you.'
      redirect_to :action => 'index'
    end
  end
  
  def show
    @release = Release.find_by_permalink(params[:permalink], :select => "id, user_id, name, details, (select left(details, 200)) AS description, release_type, release_date, tags, download_url, releasenotes_url, website")
    @release_comments = Comment.find(:all, :conditions => 'release_id = ' + @release.id.to_s + ' and approved = 1', :order => 'created_at DESC')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    @title = @release.name + " : "
    @description = @release.description
    
    render :layout => 'release_view'
  end
  
  def master_feed
    @feed_title = 'Open Source Release Feed'
    
    from = Date.today - 14
    to = Date.today
    
    @releases = Release.find(:all, :select => "id, name, (select left(details, 200)) AS details, created_at, permalink", :conditions => ["status = 'active' and release_date BETWEEN ? and ?", from, to], :order => 'id DESC')
    render :layout => false
  end
  
  def java_feed
    @feed_title = 'Java Open Source Release Feed'
    fetch_rss_releases("MATCH (tags) AGAINST ('java')")
    render :layout => false
  end
  
  def php_feed
    @feed_title = 'PHP Open Source Release Feed'
    fetch_rss_releases("MATCH (tags) AGAINST ('php')")
    render :layout => false
  end
  
  def apache_feed
    @feed_title = 'Apache Open Source Release Feed'
    fetch_rss_releases("MATCH (tags) AGAINST ('apache')")
    render :layout => false
  end
  
  def server_feed
    @feed_title = 'Server Open Source Release Feed'
    fetch_rss_releases("MATCH (tags) AGAINST ('server')")
    render :layout => false
  end
  
  def javascript_feed
    @feed_title = 'JavaScript Open Source Release Feed'
    fetch_rss_releases("MATCH (tags) AGAINST ('javascript')")
    render :layout => false
  end
  
  def rss
    @feed_title = 'Open Source Release Feed'
    fetch_rss_releases("tags like '%mys%'")
    render :layout => false
  end
  
  private
  def fetch_rss_releases(conditions)
    @releases = Release.find(:all, :select => "id, name, (select left(details, 200)) AS details, release_date, permalink", :conditions => conditions, :order => 'release_date DESC')
  end
end