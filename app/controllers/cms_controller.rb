class CmsController < ApplicationController
  
  before_filter :admin_login_required
  
  layout 'cms'
  
  def index
    @metadata = get_metadata('cms')
    
    @release_count = Release.count(:conditions => "status = 'active'")
    
    @article_count = Article.count(:conditions => "status = 'active'")
    @article_draft_count = Article.count(:conditions => "status = 'draft'")
    
    @user_count = User.count(:conditions => "user_level = 'user' OR user_level = 'admin'")
  end
  
  def show_content
    @contents = get_metadata('cms')
    @metadata = MetaData.find(:all, :order => 'id DESC')
  end
  
  def new_content
    @content = get_metadata('cms')
    
    if request.post?
      @newContent = MetaData.new(params[:metadata])
      @newContent.save
      
      redirect_to :controller => 'cms', :action => 'show_content'
      flash[:notice] = 'Content added successfully'
    end
  end
  
  def edit_content
    @content = get_metadata('cms')
    @metadata = MetaData.find_by_id(params[:id])
    
    if request.post?
      @metadata = MetaData.find_by_id(params[:id])
      unless @metadata.nil?
        @metadata.update_attributes(params[:metadata])
        @metadata.save
        
        redirect_to :controller => 'cms', :action => 'show_content'
        flash[:notice] = 'Record updated successfully'
      else
        redirect_to :controller => 'cms', :action => 'show_content'
        flash[:error] = 'Record not found.'
      end
    end
  end
  
  def delete_content
   @metadata = MetaData.find_by_id(params[:id])
   unless @metadata.nil?
     MetaData.delete(@metadata)
     
     redirect_to :controller => 'cms', :action => 'show_content'
     flash[:notice] = 'Content item removed.'
   else
     redirect_to :controller => 'cms', :action => 'show_content'
     flash[:error] = 'Record not found.'
   end
  end
  
  def release_queue
    @metadata = get_metadata('cms')    
    @releases = Release.find(:all, :conditions => 'status = "moderating"')    
  end
  
  def active_release_queue
    @metadata = get_metadata('cms')    
    @releases = Release.fetch_active_releases('status = "active"', params[:page])   
  end
  
  def new_release
    @metadata = get_metadata('cms')
    @release_types = ReleaseTypes.find(:all)
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    
    if request.post?
      @newRelease = Release.new(params[:release])
      @newRelease.user = @current_user
      @newRelease.status = 'moderating'
      @newRelease.save
      
      flash[:notice] = 'Release notification submitted for moderation. Thank you.'
      redirect_to :controller => 'cms', :action => 'release_queue'
    end
  end
  
  def edit_release
    @metadata = get_metadata('cms')    
    @release = Release.find_by_id(params[:id])
    
    if request.post?
      @release = Release.find_by_id(params[:id])
      unless @release.nil?
        @release.update_attributes(params[:release])
        @release.save
        
        redirect_to :controller => 'cms', :action => 'release_queue'
        flash[:notice] = 'Release updated successfully'
      else
        redirect_to :controller => 'cms', :action => 'release_queue'
        flash[:error] = 'Release with specified id not found.'
      end      
    end
  end
  
  def approve_release
    @release = Release.find_by_id(params[:id])
    
    unless @release.nil?
      @release.update_attribute('status', 'active')
      @release.save
      
      Notifier.deliver_announcement_approved(@release, @release.user)
      
      redirect_to :controller => 'cms', :action => 'release_queue'
      flash[:notice] = 'Release approved successfully'
    else
      redirect_to :controller => 'cms', :action => 'release_queue'
      flash[:error] = 'Release with specified id not found.'
    end
  end
  
  def remove_release
    @release = Release.find_by_id(params[:id])
    
    unless @release.nil?
      Release.delete(@release)
      redirect_to :controller => 'cms', :action => 'release_queue'
      flash[:notice] = 'Release deleted successfully'
    else
      redirect_to :controller => 'cms', :action => 'release_queue'
      flash[:error] = 'Release with specified id not found.'
    end
  end
  
  def show_active_interviews
    @interviews = Interview.fetch_active_interviews('status = "active"', params[:page])
    @metadata = get_metadata('cms')
  end
  
  def show_draft_interviews
    @interviews = Interview.fetch_draft_interviews('status = "draft"', params[:page])
    @metadata = get_metadata('cms')
  end
  
  def new_interview
   @metadata = get_metadata('cms')
   
   if request.post?
     @newInterview = Interview.new
     @newInterview.upload_interview = params[:interview]
     @newInterview.update_attribute("status", "active")
     @newInterview.save
     
     flash[:notice] = 'New interview added successfully.'
     redirect_to :controller => 'interview', :action => 'index'     
   end
 end
 
 def new_draft_interview
   @metadata = get_metadata('cms')
   
   if request.post?
     @newInterview = Interview.new
     @newInterview.upload_interview = params[:interview]
     @newInterview.update_attribute("status", "draft")
     @newInterview.save
     
     flash[:notice] = 'New interview added successfully.'
     redirect_to :controller => 'interview', :action => 'index'     
   end
 end
 
 def edit_interview
   @interview = Interview.find_by_id(params[:id])
   @metadata = get_metadata('cms')
   
   if request.post?
     @interview = Interview.find_by_id(params[:id])
     
     unless @interview.nil?
        @interview.update_attributes(params[:interview])
        @interview.save
        
        redirect_to :controller => 'cms', :action => 'show_interviews'
        flash[:notice] = 'Interview updated successfully'
      else
        redirect_to :controller => 'cms', :action => 'show_interviews'
        flash[:error] = 'Interview with specified id not found.'
      end
   end
 end
 
 def delete_interview
   @interview = Interview.find_by_id(params[:id])
   delete(@interview)
   redirect_to :controller => 'cms', :action => 'show_interviews'
   flash[:notice] = 'Interview deleted successfully'
 end
 
 # ARTICLE METHODS
 def new_article
   @metadata = get_metadata('cms')
   
   if request.post?
     @newArticle = Article.new
     # Save article in preview status
     # @params :article = The complete Article object
     # @params status
     @newArticle.upload_article(params[:article], "preview")
     @newArticle.save
     
     flash[:notice] = "New article added successfully."
     redirect_to :controller => "cms", :action => "article_preview", :id => @newArticle.id
   end
 end
 
 def article_preview
    @metadata = get_metadata('articles')
    @article = Article.find_by_id(params[:id], :select => "id, title, lead, detail, photo, tag, permalink")
    
    @title = @article.title + ' : '
    render :layout => 'article_preview'
 end
 
 def manage_article_draft_queue
   @articles = Article.find(:all, :select => 'id, title', :conditions => 'status = "draft"', :order => 'id DESC')
   @metadata = get_metadata('cms')
 end
 
 def manage_article_queue
   @articles = Article.find(:all, :select => 'id, title', :conditions => 'status = "active"', :order => 'id DESC')
   @metadata = get_metadata('cms')
 end
 
 def edit_article
   @metadata = get_metadata('cms')
   @article = Article.find_by_id(params[:id])
   
   if request.post?
     @article = Article.find_by_id(params[:id])
     
     unless @article.nil?
       @article.update_attributes(params[:article])
       @article.save
        
       redirect_to :controller => 'cms', :action => 'index'
       flash[:notice] = 'Interview updated successfully'
     else
       redirect_to :controller => 'cms', :action => 'index'
       flash[:error] = 'Article with specified id not found.'
     end
   end
 end
 
 def update_article_status
   @article = Article.find_by_id(params[:id])
   unless @article.nil?
     @article.update_attribute("status", params[:status])
     flash[:notice] = "Article updated successfully."
     redirect_to :controller => 'cms', :action => 'index'
   end
 end
 
 def delete_article
   @article = Article.find_by_id(params[:id])
   Article.delete(@article)
   redirect_to :controller => 'cms', :action => 'index'
   flash[:notice] = 'Article deleted successfully'
 end
 
 def new_resource
   @metadata = get_metadata('cms')
   
   if request.post?
     @newResource = Resource.new
     @newResource.upload_resource = params[:resource]
     @newResource.save
     
     flash[:notice] = "New resource added successfully."
     redirect_to :controller => "resource", :action => "index"     
   end
 end
 
 def new_package
   @metadata = get_metadata('cms')
   
   if request.post?
     @newPackage = Package.new
     @newPackage.upload_package = params[:package]
     @newPackage.save
     
     flash[:notice] = "New package added successfully."
     redirect_to :controller => "cms", :action => "index"
   end
 end
 
 def show_requested_feeds
   @metadata = get_metadata('cms')   
   @feeds = Feed.find(:all, :conditions => "status = 'requested'")
 end
 
 def activate_feed
    @metadata = get_metadata('cms')
    
    @feeds = Feed.find(:all, :conditions => "status = 'pending'")
    
    if request.post?
      @feed = Feed.find_by_id(params[:feed_id])
      
      @feed.feedburner = params[:feedburner]
      @feed.chicklet = params[:chicklet]
      @feed.status = "active"
      
      @feed.save
      
      Notifier.deliver_new_custom_feed_activated(@feed, @feed.user)
      
      flash[:notice] = "Feed activated successfully."
      redirect_to :controller => "cms", :action => "index"
    end
  end
  
  def create_news
    @metadata = get_metadata('cms')
    
    if request.post?
      @news = News.new(params[:news])
      @news.write_attribute("status", "moderating")
      @news.save
      
      flash[:notice] = "News item added successfully."
      redirect_to :controller => 'cms', :action => 'show_news'
    end
  end

  def show_news
    @metadata = get_metadata('cms')    
    @news = News.find(:all, :select => 'id, headline, status', :order => 'id DESC')
  end

  def edit_news
    @metadata = get_metadata('cms')
    @news = News.find_by_id(params[:id])
    
    if request.post?
      @news = News.find_by_id(params[:id])
      unless @news.nil?
        @news.update_attributes(params[:news])
        @news.save
        flash[:notice] = 'News item successfully updated.'
        redirect_to :controller => 'cms', :action => 'show_news'
      else
        flash[:warning] = 'News item with provided id not found'
        redirect_to :controller => 'cms', :action => 'show_news'
      end
    end
  end
  
  def delete_news
    @news = News.find_by_id(params[:id])
    unless @news.nil?
      News.delete(@news)
      flash[:notice] = 'News item deleted successfully.'
      redirect_to :controller => 'cms', :action => 'show_news'
    else
      flash[:warning] = 'News item with provided id not found'
      redirect_to :controller => 'cms', :action => 'show_news'
    end
  end
  
  def approve_news
    @news = News.find_by_id(params[:id])
    unless @news.nil?
      @news.update_attribute("status", "active")
      @news.save
      
      flash[:notice] = 'News item active.'
      redirect_to :controller => 'cms', :action => 'show_news'
    else
      flash[:warning] = 'News item with provided id not found'
      redirect_to :controller => 'cms', :action => 'show_news'
    end
  end
  
  #EVENTS
  def create_event
    @metadata = get_metadata('cms')
    
    if request.post?
      @event = Event.new(params[:news])
      @event.write_attribute("status", "moderating")
      @event.save
      
      flash[:notice] = "Event added successfully."
      redirect_to :controller => 'cms', :action => 'show_events'
    end
  end

  def show_events
    @metadata = get_metadata('cms')    
    @event = Event.find(:all, :select => 'id, headline, status', :order => 'id DESC')
  end

  def edit_event
    @metadata = get_metadata('cms')
    @event = Event.find_by_id(params[:id])
    
    if request.post?
      @event = Event.find_by_id(params[:id])
      unless @event.nil?
        @event.update_attributes(params[:event])
        @event.save
        flash[:notice] = 'Event successfully updated.'
        redirect_to :controller => 'cms', :action => 'show_events'
      else
        flash[:warning] = 'Event with provided id not found'
        redirect_to :controller => 'cms', :action => 'show_events'
      end
    end
  end
  
  def delete_event
    @event = Event.find_by_id(params[:id])
    unless @event.nil?
      Event.delete(@event)
      flash[:notice] = 'News item deleted successfully.'
      redirect_to :controller => 'cms', :action => 'show_events'
    else
      flash[:warning] = 'Event with provided id not found'
      redirect_to :controller => 'cms', :action => 'show_events'
    end
  end
  
  def approve_event
    @event = Event.find_by_id(params[:id])
    unless @event.nil?
      @event.update_attribute("status", "active")
      @event.save
      
      flash[:notice] = 'Event active.'
      redirect_to :controller => 'cms', :action => 'show_events'
    else
      flash[:warning] = 'Event with provided id not found'
      redirect_to :controller => 'cms', :action => 'show_events'
    end
  end
end