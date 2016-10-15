class Image < ActiveRecord::Base
  mount_uploader :image, PrototypeImageUploader

  belongs_to :prototype

  validates_presence_of :image, :status

  enum status: { main: 0, sub: 1 }
end
