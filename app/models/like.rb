class Like < ActiveRecord::Base
  belongs_to :prototype
  belongs_to :user
end
