class Image < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :prototype

  enum status: { main: 0, sub: 1 }
end
