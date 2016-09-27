class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name,presence: true

  has_many :prototypes
  has_many :likes
  has_many :comments

  mount_uploader :avatar, AvatarUploader

end
