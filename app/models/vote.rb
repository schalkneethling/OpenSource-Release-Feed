class Vote < ActiveRecord::Base
  belongs_to :release, :counter_cache => true
  belongs_to :user
end
