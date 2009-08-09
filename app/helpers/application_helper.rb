# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def get_tags
    @tags = Tag.find(:all)
  end
  
  def get_release_types
    @releasetypes = ReleaseTypes.find(:all)
  end
end