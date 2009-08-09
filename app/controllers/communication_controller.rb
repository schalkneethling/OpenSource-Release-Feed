class CommunicationController < ApplicationController
  
  def feedback
    @metadata = get_metadata('feedback')
    @users = User.find(:all, :select => 'id, login, email', :conditions => "user_level = 'user' or user_level = 'admin'")
    
    if request.post?
      @feedback = Contact.new(params[:contact])
      @feedback.request = request
      if @feedback.save
        if @feedback.approved?
          Notifier.deliver_feedback(@feedback)
          flash[:notice] = 'Thank you for your feedback. If your message requires a response from us, we will get back to you within 24 hours.'
        else
          flash[:error] = 'Unfortunately your message is considered spam by Akismet. If you believe this to be an error please send us an email at support@opensourcereleasefeed.com'
        end
        redirect_to :controller => 'release', :action => 'index'
        end
      end
    end    
end