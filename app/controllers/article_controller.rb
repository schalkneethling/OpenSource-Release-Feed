class ArticleController < ApplicationController
  
  def index
    @articles = Article.fetch_articles(params[:page])
    fetch_metadata
    render :layout => 'article_view'
  end
  
  def show
    fetch_metadata
    
    @article = Article.find_by_permalink(params[:permalink], :select => "id, title, lead, detail, photo, tag")
    @article_comments = Comment.find(:all, :conditions => 'article_id = ' + @article.id.to_s + ' and approved = 1', :order => 'created_at DESC')
    fetch_related_releases("MATCH (tags) AGAINST ('" + @article.tag + "')")
    
    @title = @article.title + ' : '
    render :layout => 'article_view'
  end
  
  def book_reviews
    @metadata = get_metadata('articles')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    
    @bookreviews = Article.fetch_bookreviews(params[:page])
    
    render :layout => 'bookreview_view'
  end
  
  def show_book_review
    @book_review = Article.find_by_permalink(params[:permalink], :select => "id, title, lead, detail, photo, tag")
    fetch_related_releases("MATCH (tags) AGAINST ('" + @book_review.tag + "')")
    
    @title = @book_review.title + ' : '
    render :layout => 'bookreview_view'
  end
  
  def community_reviews
    @metadata = get_metadata('articles')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    
    @community_reviews = Article.fetch_community_reviews(params[:page])
    
    render :layout => 'community_review_view'
  end
  
  def show_community_review
    @community_review = Article.find_by_permalink(params[:permalink], :select => "id, title, lead, detail, photo, tag")
    fetch_related_releases("MATCH (tags) AGAINST ('" + @article.tag + "')")
    
    @title = @community_review.title + ' : '
    render :layout => 'bookreview_view'
  end
  
  def article_feed
    @feed_title = 'OpenSource Release Feed Articles'
    @articles = Article.find(:all, :select => "title, lead, permalink", :order => 'id DESC')
    render :layout => false
  end
  
  private
  def fetch_related_releases(conditions)
    @releases = Release.find(:all, :select => "id, name, (select left(details, 200)) AS details, release_date, permalink", :conditions => conditions, :order => 'release_date DESC', :limit => '5')
  end
  
  def fetch_metadata
    @metadata = get_metadata('articles')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
  end
end