#User
##association
- has_many :prototypes
- has_many :likes
- has_many :comments

##table
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

##table
- user_id
- catch_copy
- concept
- tag
- created_at
- updated_at


#CapturedImage
##association
- belongs_to :prototype

##table
- prototype_id
- image
- created_at
- updated_at



#Like
##association
- belongs_to :prototype
- belongs_to :user

##table
- prototype_id
- user_id
- created_at
- updated_at




#Comment
##association
- belongs_to :user
- belongs_to :prototype

##table
- content
- user_id
- prototype_id
- created_at
- updated_at
