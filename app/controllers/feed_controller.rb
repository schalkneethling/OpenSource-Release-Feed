class FeedController < ApplicationController
  
  def view_custom_feeds
    @metadata = get_metadata('custom-feeds')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    @community_feeds = Feed.find(:all, :conditions => "status = 'active'", :order => "id DESC")
    render :layout => 'custom_feeds_view'
  end
  
  def all_feeds
    @metadata = get_metadata('default-feeds')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    render :layout => 'custom_feeds_view'
  end
  
  def request_feed    
    if request.post?
      @new_feed = Feed.new
      
      @new_feed.write_attribute("tags", params[:selected_tags].join(" "))
      @new_feed.write_attribute("release_types", params[:release_types].join(" "))
      @new_feed.write_attribute("status", "requested")
      @new_feed.user = @current_user
      
      @new_feed.save
      
      Notifier.deliver_new_feed_request_alert(@current_user)
      
      flash[:notice] = 'Your feed request was received. You will receive an email as soon as your feed is activated. Thank you!'
      redirect_to :controller => 'release'
    else
      flash[:error] = 'Your feed request failed. We have been notified and will look into the possible reasons.'
      redirect_to :controller => 'release'
    end
    
  end
  
  def generate_feed
    @feed = Feed.find_by_id(params[:id])
    base_url = 'http://www.opensourcereleasefeed.com/feed/custom_feed?id='
    
    @feed.localfeed = base_url + @feed.id.to_s
    @feed.status = "pending"
    @feed.save
    
    redirect_to :controller => 'cms', :action => 'activate_feed'
  end
  
  def remove_requested_feed
    @feed = Feed.find_by_id(params[:id])
    @feed.status = "rejected"
    @feed.save
    
    Notifier.deliver_rejected_feed_request(@feed.user)
    
    flash[:notice] = 'Feed request rejected'
    redirect_to :controller => 'cms', :action => 'show_requested_feeds'
  end
  
  def custom_feed
    @feed = Feed.find_by_id(params[:id])
    @feed_title = 'Open Source Release Feed For Tags ' + @feed.tags + ' And Releases Of Type ' + @feed.release_types
    fetch_rss_releases("MATCH (tags) AGAINST ('" + @feed.tags + "') AND MATCH (release_type) AGAINST ('" + @feed.release_types + "')")
    render :layout => false
  end
  
  private
  def fetch_rss_releases(conditions)
    @releases = Release.find(:all, :select => "id, name, (select left(details, 200)) AS details, release_date, permalink", :conditions => conditions, :order => 'release_date DESC')
  end
end