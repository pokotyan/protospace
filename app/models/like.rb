class Like < ActiveRecord::Base
  belongs_to :prototype, counter_cache: true
  belongs_to :user
end
