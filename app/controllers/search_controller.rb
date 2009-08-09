class SearchController < ApplicationController
  def index
    @metadata = get_metadata('home')
    @title = 'Access All Of The Latest Open Source Releases : '
    
    render :layout => 'search_results'
  end
end
