class CommentController < ApplicationController
  
  def index    
  end
  
  def create
    @comment = Comment.new(params[:comment])
    # Set the event id on the comment to that of the current event
    @comment.update_attribute(:release_id, params[:comment][:release_id])
    # Adds the current logged in users credentials to the comment
    @comment.user = @current_user
    @comment.commentor = @current_user
    # Adds the request attributes to the comment for Akismet
    @comment.request = request    
    if @comment.save and @comment.approved?
      flash[:notice] = 'Thank you for your comment.'
    else
      flash[:error] = 'Unfortunately your comment is considered spam by Akismet. It will show up once an administrator has approved it.'
    end
    redirect_to :controller => 'release', :action => 'show', :permalink => @comment.release.permalink
  end
  
  def create_article_comment
    @comment = Comment.new(params[:comment])
    # Set the event id on the comment to that of the current event
    @comment.update_attribute(:article_id, params[:comment][:article_id])
    # Adds the current logged in users credentials to the comment
    @comment.user = @current_user
    @comment.commentor = @current_user
    # Adds the request attributes to the comment for Akismet
    @comment.request = request    
    if @comment.save and @comment.approved?
      flash[:notice] = 'Thank you for your comment.'
    else
      flash[:error] = 'Unfortunately your comment is considered spam by Akismet. It will show up once an administrator has approved it.'
    end
    redirect_to :controller => 'article', :action => 'show', :permalink => @comment.article.permalink
  end
  
  def create_interview_comment
    @comment = Comment.new(params[:comment])
    # Set the event id on the comment to that of the current event
    @comment.update_attribute(:interview_id, params[:comment][:interview_id])
    # Adds the current logged in users credentials to the comment
    @comment.user = @current_user
    @comment.commentor = @current_user
    # Adds the request attributes to the comment for Akismet
    @comment.request = request    
    if @comment.save and @comment.approved?
      flash[:notice] = 'Thank you for your comment.'
    else
      flash[:error] = 'Unfortunately your comment is considered spam by Akismet. It will show up once an administrator has approved it.'
    end
    redirect_to :controller => 'interview', :action => 'show', :permalink => @comment.interview.permalink
  end
  
  def create_resource_comment
    @comment = Comment.new(params[:comment])
    # Set the event id on the comment to that of the current event
    @comment.update_attribute(:resource_id, params[:comment][:resource_id])
    # Adds the current logged in users credentials to the comment
    @comment.user = @current_user
    @comment.commentor = @current_user
    # Adds the request attributes to the comment for Akismet
    @comment.request = request    
    if @comment.save and @comment.approved?
      flash[:notice] = 'Thank you for your comment.'
    else
      flash[:error] = 'Unfortunately your comment is considered spam by Akismet. It will show up once an administrator has approved it.'
    end
    redirect_to :controller => 'resource', :action => 'show', :permalink => @comment.resource.permalink
  end
  
  def create_package_comment
    @comment = Comment.new(params[:comment])
    # Set the event id on the comment to that of the current event
    @comment.update_attribute(:package_id, params[:comment][:package_id])
    # Adds the current logged in users credentials to the comment
    @comment.user = @current_user
    @comment.commentor = @current_user
    # Adds the request attributes to the comment for Akismet
    @comment.request = request    
    if @comment.save and @comment.approved?
      flash[:notice] = 'Thank you for your comment.'
    else
      flash[:error] = 'Unfortunately your comment is considered spam by Akismet. It will show up once an administrator has approved it.'
    end
    redirect_to :controller => 'package', :action => 'show', :permalink => @comment.package.permalink
  end
  
  def create_event_comment
    @comment = Comment.new(params[:comment])
    # Set the event id on the comment to that of the current event
    @comment.update_attribute(:event_id, params[:comment][:event_id])
    # Adds the current logged in users credentials to the comment
    @comment.user = @current_user
    @comment.commentor = @current_user
    # Adds the request attributes to the comment for Akismet
    @comment.request = request    
    if @comment.save and @comment.approved?
      flash[:notice] = 'Thank you for your comment.'
    else
      flash[:error] = 'Unfortunately your comment is considered spam by Akismet. It will show up once an administrator has approved it.'
    end
    redirect_to :controller => 'event', :action => 'show', :permalink => @comment.event.permalink
  end
  
  def create_news_comment
    @comment = Comment.new(params[:comment])
    # Set the event id on the comment to that of the current event
    @comment.update_attribute(:news_id, params[:comment][:news_id])
    # Adds the current logged in users credentials to the comment
    @comment.user = @current_user
    @comment.commentor = @current_user
    # Adds the request attributes to the comment for Akismet
    @comment.request = request    
    if @comment.save and @comment.approved?
      flash[:notice] = 'Thank you for your comment.'
    else
      flash[:error] = 'Unfortunately your comment is considered spam by Akismet. It will show up once an administrator has approved it.'
    end
    redirect_to :controller => 'news', :action => 'show', :permalink => @comment.news.permalink
  end
end