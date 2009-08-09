class AccountController < ApplicationController
  
  PASSWORD_REMINDER_FAILED = 'No account matching your details could be found. Please double check your information and try again. If you believe this to be an error please send your user info to us at support@globaltechnologyevents.com'

  def password_reminder
    @metadata = get_metadata('register')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    
    if request.post?
      @user = User.find_by_username_and_email_address(params[:username], params[:email])
      
      unless @user.nil?
        Notifier.deliver_password_reminder(@user)
        
        flash[:notice] = 'Password reminder sent.'
        redirect_to :action => 'password_reminder'
      else
        flash[:warning] = PASSWORD_REMINDER_FAILED
      end
    end    
  end
end