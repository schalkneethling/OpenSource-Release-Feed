class NewsController < ApplicationController
  
  before_filter :login_required, :only => [:new]
  
  layout 'news'
  
  def index
    @metadata = get_metadata('news')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    
    from = Date.today - 14
    to = Date.today    
    
    @newsitems = News.fetch_latest_news(["status = 'active' and created_at BETWEEN ? and ?", from, to], params[:page])    
    @date_range = "Since " + from.strftime("%d %B %Y")
  end
  
  def new
    @metadata = get_metadata('news')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    
    if request.post?
      @newNews = News.new(params[:news])
      @newNews.user = @current_user
      @newNews.status = 'moderating'
      @newNews.save
      
      Notifier.deliver_new_news_alert(@newNews)
      Notifier.deliver_acknowledge_new_news_submission(@newNews, @current_user)
      
      flash[:notice] = 'Link submitted for moderation. Thank you.'
      redirect_to :action => 'index'
    end
  end
  
  def show
    @news = News.find_by_permalink(params[:permalink], :select => "id, user_id, headline, description, (select left(description, 100)) AS details, tags, news_url, created_at")
    @news_comments = Comment.find(:all, :conditions => 'news_id = ' + @news.id.to_s + ' and approved = 1', :order => 'created_at DESC')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    @title = @news.headline + " : "
    render :layout => 'news_view'
  end
end
