class InterviewController < ApplicationController
  
  def index    
    @interviews = Interview.fetch_interviews(params[:page])
    @upcoming_interviews = get_metadata('upcoming-interviews')
    @metadata = get_metadata('interviews')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
  end
  
  def show
    @metadata = get_metadata('upcoming-interviews')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    @interview = Interview.find_by_permalink(params[:permalink], :select => "id, title, name, (select left(interview, 150)) AS description, interview, photo, tag")
    @interview_comments = Comment.find(:all, :conditions => 'interview_id = ' + @interview.id.to_s + ' and approved = 1', :order => 'created_at DESC')
    fetch_related_releases("MATCH (tags) AGAINST ('" + @interview.tag + "')")
    @title = @interview.title + ' : '
    render :layout => 'interview_view'
  end
  
  def interview_feed
    @feed_title = 'OpenSource Release Feed Interviews'
    @interviews = Interview.find(:all, :select => "title, lead, permalink", :order => 'id DESC')
    render :layout => false
  end
  
  private
  def fetch_related_releases(conditions)
    @releases = Release.find(:all, :select => "id, name, (select left(details, 200)) AS details, release_date, permalink", :conditions => conditions, :order => 'release_date DESC', :limit => '5')
  end
end