class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject += 'Please Activate Your New Account'  
    @body[:url]  = "http://www.opensourcereleasefeed.com/activate/#{user.activation_code}"  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your Account Has Been Activated!'
    @body[:url]  = "http://www.opensourcereleasefeed.com/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "donotreply@opensourcereleasefeed.com"
      @subject     = "OpenSource Release Feed "
      @sent_on     = Time.now
      @body[:user] = user
    end
end