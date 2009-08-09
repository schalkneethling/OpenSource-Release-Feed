class ResourceController < ApplicationController
  def index
    @resources = Resource.fetch_resources(params[:page])
    @metadata = get_metadata('tools')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    render :layout => 'article_view'
  end
  
  def show
    @metadata = get_metadata('tools')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    @resource = Resource.find_by_permalink(params[:permalink], :select => "id, title, lead, detail, photo, tag")
    @resource_comments = Comment.find(:all, :conditions => 'resource_id = ' + @resource.id.to_s + ' and approved = 1', :order => 'created_at DESC')
    fetch_related_releases("MATCH (tags) AGAINST ('" + @resource.tag + "')")
    
    @title = @resource.title + ' : '
    render :layout => 'article_view'
  end
  
  def resource_feed
    @feed_title = 'OpenSource Release Feed Articles'
    @resources = Article.find(:all, :select => "title, lead, permalink", :order => 'id DESC')
    render :layout => false
  end
  
  private
  def fetch_related_releases(conditions)
    @releases = Release.find(:all, :select => "id, name, (select left(details, 200)) AS details, release_date, permalink", :conditions => conditions, :order => 'release_date DESC', :limit => '5')
  end
end