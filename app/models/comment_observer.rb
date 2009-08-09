class CommentObserver < ActiveRecord::Observer
  
  def after_save(comment)
    Notifier.deliver_new_comment(comment, comment.user)
  end  
end