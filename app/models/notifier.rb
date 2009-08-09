class Notifier < ActionMailer::Base
  
  def feedback(feedback)
    # Email header info MUST be added here
    recipients "info@opensourcereleasefeed.com"
    from "donotreply@opensourcereleasefeed.com"
    subject "OpenSource Release Feed: Feedback"
    
    # Email body substitution goes here
    body "<h3>Greetings, </h3>" +
         "The following person or company has sent you a message" +
         "<p>Name: " + feedback.name + "</p>" +         
         "<p>Email Address: " + feedback.email + "</p>" +
         "<p>Message: " + feedback.message + "</p>" +
         "<p>Kind Regards, <br />" + 
         "The OpenSource Release Feed Team</p>"
    content_type "text/html"
  end
  
  def password_reminder(user)
    # Email header info MUST be added here
    recipients user.email
    from "donotreply@opensourcereleasefeed.com"
    subject "OpenSource Release Feed : Password Reminder"
    
    # Email body substitution goes here
    body "<h3>Greetings, </h3>" +
         "<p>Below is your requested account information.</p>" +
         "<p>Username: " + user.username + "</p>" +
         "<p>Password: " + user.password + "</p>" +         
         "<p>Kind Regards, <br />" + 
         "The OpenSource Release Feed Team</p>"
    content_type "text/html"
  end
  
  def new_release_alert(release)
    # Email header info MUST be added here
    recipients "info@opensourcereleasefeed.com"
    from "donotreply@opensourcereleasefeed.com"
    subject "OpenSource Release Feed: New Release Announcement"
    
    # Email body substitution goes here
    body "<h3>Greetings, </h3>" +
         "The following new releaset has just been submitted on Open Source Release Feed" +
         "<p>Name: " + release.name + "</p>" +         
         "<p>Details: " + release.details + "</p>" +
         "<p>Kind Regards, <br />" + 
         "The OpenSource Release Feed Team</p>"
    content_type "text/html"
  end
  
  def acknowledge_new_release_submission(release, user)
    # Email header info MUST be added here
    recipients user.email
    from "donotreply@opensourcereleasefeed.com"
    subject "OpenSource Release Feed: New Release Submission"
    
    # Email body substitution goes here
    body "<h3>Greetings, </h3>" +
         "<p>Thank you for submitting a new release announcement to Open Source Release Feed. The release announcement has been submitted for moderation</p>" +
         "<p>Your release announcement details are as follows: </p>" +
         "<p>Name: " + release.name + "</p>" +         
         "<p>Details: " + release.details + "</p>" +
         "<p>Thank you again for participating on Open Source Release Feed, without the participation of people such as yourself, Open Source Release Feed will not exist.</p>" +
         "<p>Kind Regards, <br />" + 
         "The OpenSource Release Feed Team</p>"
    content_type "text/html"    
  end
  
  def announcement_approved(release, user)
    # Email header info MUST be added here
    recipients user.email
    from "donotreply@opensourcereleasefeed.com"
    subject "OpenSource Release Feed: Release Announcement Approved!"
    
    # Email body substitution goes here
    body '<h3>Greetings, </h3>' +
         '<p>Thank you for your submission to Open Source Release Feed. The release announcement is now live at:</p>' +
         '<p><a href="http://www.opensourcereleasefeed.com/release/show/' + release.permalink + '">' + release.name + '</a></p>' +
         '<p>Thank you again for participating on Open Source Release Feed, without the participation of people such as yourself, Open Source Release Feed will not exist.</p>' +
         '<p>Kind Regards, <br />' + 
         'The OpenSource Release Feed Team</p>'
    content_type "text/html"
  end
  
  def new_comment(comment, user)
    # Email header info MUST be added here
    recipients "support@opensourcereleasefeed.com"
    from "donotreply@opensourcereleasefeed.com"
    subject "OpenSource Release Feed : New Comment"
    
    # Email body substitution goes here
    body "<h3>Greetings, </h3>" +
         "<p>A new comment has been added by " + user.login + ".</p>" +
         "<p>Email: " + comment.email + "</p>" +
         "<p>Comment: " + comment.comment + "</p>" +
         "<p>Kind Regards, <br />" + 
         "The OpenSource Release Feed Team</p>"
    content_type "text/html"
  end
  
  def new_feed_request_alert(user)
    # Email header info MUST be added here
    recipients "support@opensourcereleasefeed.com"
    from "donotreply@opensourcereleasefeed.com"
    subject "OpenSource Release Feed : New Feed Request"
    
    # Email body substitution goes here
    body '<h3>Greetings, </h3>' +
         '<p>A new custom feed has been requested by ' + user.login + '.</p>' +
         '<p>Please review the list of requested feeds: <a href="http://www.opensourcereleasefeed.com/cms/show_requested_feeds">Process requests</a></p>' +
         '<p>Kind Regards, <br />' + 
         'The OpenSource Release Feed Team</p>'
    content_type 'text/html'
  end
  
  def rejected_feed_request(user)
    # Email header info MUST be added here
    recipients user.email
    from "donotreply@opensourcereleasefeed.com"
    subject "OpenSource Release Feed : Feed Request Rejected"
    
    # Email body substitution goes here
    body '<h3>Greetings, </h3>' +
         '<p>Unfortunately your latest custom feed request was rejected by one of our moderators. The reasons for this may be any one of the following:</p>' +
         '<p>A feed matching your criteria already exists, please <a href="http://www.opensourcereleasefeed.com/feed/view_custom_feeds">review our custom feeds page</a> or, a previous custom feed request from this same account has been rejected and marked as spam.</p>' +
         '<p>If you believe this to be in error please drop us a note at support@opensourcereleasefeed.com and we will gladly assist you.' +
         '<p>Kind Regards, <br />' + 
         'The OpenSource Release Feed Team</p>'
    content_type 'text/html'
  end
  
  def new_custom_feed_activated(feed, user)
    # Email header info MUST be added here
    recipients user.email
    from "donotreply@opensourcereleasefeed.com"
    subject "OpenSource Release Feed : Requested Custom Feed Active"
    
    # Email body substitution goes here
    body '<h3>Greetings, </h3>' +
         '<p>Congratulations! Your requested custom feed has been accepted and is now accessible at the following URL:</p>' +
         '<p><a href="' + feed.feedburner + '" title="Subscribe to your feed">' + feed.feedburner + '</a></p>' +
         '<p>If in future you loose access to this feed you can always subscribe again by <a href="http://www.opensourcereleasefeed.com/feed/view_custom_feeds">accessing your feed from our custom community feeds page</a>.' +
         '<p>We love to hear feedback from our users so, if you have any suggestions on how we can improve OpenSource Release Feed please do not hesitate to send us a mail at support@opensourcereleasefeed.com. Thank you for your support.</p>' +
         '<p>Kind Regards, <br />' + 
         'The OpenSource Release Feed Team</p>'
    content_type 'text/html'
  end
  
  # NEWS MAILERS
  def new_news_alert(news)
    # Email header info MUST be added here
    recipients "info@opensourcereleasefeed.com"
    from "donotreply@opensourcereleasefeed.com"
    subject "OpenSource Release Feed: New Link"
    
    # Email body substitution goes here
    body "<h3>Greetings, </h3>" +
         "The following new news item has just been submitted on Open Source Release Feed" +
         "<p>Heading: " + news.headline + "</p>" +         
         "<p>Details: " + news.description + "</p>" +
         "<p>Kind Regards, <br />" + 
         "The OpenSource Release Feed Team</p>"
    content_type "text/html"
  end
  
  def acknowledge_new_news_submission(news, user)
    # Email header info MUST be added here
    recipients user.email
    from "donotreply@opensourcereleasefeed.com"
    subject "OpenSource Release Feed: New News Submission"
    
    # Email body substitution goes here
    body "<h3>Greetings, </h3>" +
         "<p>Thank you for submitting a new news item to Open Source Release Feed. The news item has been submitted for moderation</p>" +
         "<p>Your news item details are as follows: </p>" +
         "<p>Heading: " + news.headline + "</p>" +         
         "<p>Details: " + news.description + "</p>" +
         "<p>Thank you again for participating on Open Source Release Feed, without the participation of people such as yourself, Open Source Release Feed will not exist.</p>" +
         "<p>Kind Regards, <br />" + 
         "The OpenSource Release Feed Team</p>"
    content_type "text/html"    
  end
  
  # EVENT MAILERS
  def new_event_alert(event)
    # Email header info MUST be added here
    recipients "info@opensourcereleasefeed.com"
    from "donotreply@opensourcereleasefeed.com"
    subject "OpenSource Release Feed: New Event"
    
    # Email body substitution goes here
    body "<h3>Greetings, </h3>" +
         "The following new event has just been submitted on Open Source Release Feed" +
         "<p>Event: " + event.headline + "</p>" +         
         "<p>Details: " + event.description + "</p>" +
         "<p>Kind Regards, <br />" + 
         "The OpenSource Release Feed Team</p>"
    content_type "text/html"
  end
  
  def acknowledge_new_event_submission(event, user)
    # Email header info MUST be added here
    recipients user.email
    from "donotreply@opensourcereleasefeed.com"
    subject "OpenSource Release Feed: New Event Submission"
    
    # Email body substitution goes here
    body "<h3>Greetings, </h3>" +
         "<p>Thank you for submitting a new event to Open Source Release Feed. The event has been submitted for moderation</p>" +
         "<p>Your event details are as follows: </p>" +
         "<p>Event: " + event.headline + "</p>" +         
         "<p>Details: " + event.description + "</p>" +
         "<p>Thank you again for participating on Open Source Release Feed, without the participation of people such as yourself, Open Source Release Feed will not exist.</p>" +
         "<p>Kind Regards, <br />" + 
         "The OpenSource Release Feed Team</p>"
    content_type "text/html"    
  end
end