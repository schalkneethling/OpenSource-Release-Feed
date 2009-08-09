class Contact < ActiveRecord::Base
  
  before_create :check_for_spam
  
  validates_presence_of :name, :email, :message
  
  def request=(request)
    self.user_ip = request.remote_ip
    self.user_agent = request.env['HTTP_USER_AGENT']
    self.referrer = request.env['HTTP_REFERER']
  end
  
  # Akismetor http://svn.railscasts.com/public/plugins/akismetor/
  def check_for_spam
    self.approved = !Akismetor.spam?(akismet_attributes)
    true # return true so it does not stop save
  end
  
  def akismet_attributes
    {
      :key => AKISMET,
      :blog => LOCALE_SITE_URL,
      :user_ip => user_ip,
      :user_agent => user_agent,
      :comment_author => name,
      :comment_author_email => email,
      :comment_content => message
    }
  end
end