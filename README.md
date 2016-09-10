#User
##association
- has_many :prototypes
- has_many :likes
- has_many :comments

##column
- name
- email
- profile
- works
- top_aligned_media
- avatar
- created_at
- updated_at


#Prototype
##association
- belongs_to :user
- has_many :captured_images
- has_many :liked_users, through: :likes, source: :user
- has_many :comments

##column
- user_id
- catch_copy
- concept
- created_at
- updated_at


#CapturedImage
##association
- belongs_to :prototype

##column
- prototype_id
- image
- created_at
- updated_at



#Like
##association
- belongs_to :prototype
- belongs_to :user

##column
- prototype_id
- user_id
- created_at
- updated_at




#Comment
##association
- belongs_to :user
- belongs_to :prototype

##column
- content
- user_id
- prototype_id
- created_at
- updated_at
