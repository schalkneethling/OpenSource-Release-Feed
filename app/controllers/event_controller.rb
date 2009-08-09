class EventController < ApplicationController
  
  before_filter :login_required, :only => [:new]
  
  layout 'events'
  
  def index
    @metadata = get_metadata('events')
    
    from = Date.today
    to = Date.today + 30   
    
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    @events = Event.fetch_latest_events(["status = 'active' and event_date BETWEEN ? and ?", from, to], params[:page])
  end
  
  def new
    @metadata = get_metadata('new-event')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    
    if request.post?
      @newEvent = Event.new(params[:event])
      @newEvent.user = @current_user
      @newEvent.status = 'moderating'
      @newEvent.save
      
      Notifier.deliver_new_event_alert(@newEvent)
      Notifier.deliver_acknowledge_new_event_submission(@newEvent, @current_user)
      
      flash[:notice] = 'Event submitted for moderation. Thank you.'
      redirect_to :action => 'index'
    end
  end
  
  def show
    @event = Event.find_by_permalink(params[:permalink], :select => "id, user_id, headline, description, (select left(description, 100)) AS details, tags, event_url, event_date")
    @event_comments = Comment.find(:all, :conditions => 'event_id = ' + @event.id.to_s + ' and approved = 1', :order => 'created_at DESC')
    @title = @event.headline + " : "
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    render :layout => 'event_view'
  end
end