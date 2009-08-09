class PackageController < ApplicationController
  def index
    @packages = Package.fetch_packages(params[:page])
    @metadata = get_metadata('packageit')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    render :layout => 'article_view'
  end
  
  def show
    @metadata = get_metadata('packageit')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    @package = Package.find_by_permalink(params[:permalink], :select => "id, title, lead, detail, logo, download, tag")
    @package_comments = Comment.find(:all, :conditions => 'package_id = ' + @package.id.to_s + ' and approved = 1', :order => 'created_at DESC')
    fetch_related_releases("MATCH (tags) AGAINST ('" + @package.tag + "')")
    
    @title = @package.title + ' : '
    render :layout => 'article_view'
  end
  
  def package_feed
    @feed_title = 'OpenSource Release Feed PackageIT'
    @packages = Package.find(:all, :select => "title, lead, permalink", :order => 'id DESC')
    render :layout => false
  end
  
  private
  def fetch_related_releases(conditions)
    @releases = Release.find(:all, :select => "id, name, (select left(details, 200)) AS details, release_date, permalink", :conditions => conditions, :order => 'release_date DESC', :limit => '5')
  end
end