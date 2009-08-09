# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  require 'gravtastic'
  
  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time
  before_filter :fetch_logged_in_user
  
  include ExceptionLoggable

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e129b492956f882e5028d51c2d060f0b'
  
  protected
  def get_metadata(page)
    return MetaData.find_by_page(page)
  end
  
  def login_required
    return true if logged_in?
    session[:return_to] = request.request_uri
    redirect_to '/login' and return false
  end
  
  def admin_login_required
    return true if admin_logged_in?
    session[:return_to] = request.request_uri
    redirect_to '/login' and return false
  end
  
  def fetch_logged_in_user
    return if session[:user_id].blank?
    @current_user = User.find_by_id(session[:user_id])
  end
  
  def logged_in?
    ! @current_user.blank?
  end
  
  def admin_logged_in?
    ! @current_user.blank? and @current_user.user_level.eql? 'admin'
  end
  
  helper_method :logged_in?
  helper_method :admin_logged_in?
  
  private  
  def local_request?
    false
  end
end
