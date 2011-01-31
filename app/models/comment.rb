class Comment < ActiveRecord::Base
  has_many :posts, :dependent => :destroy, :order => "created_at ASC" # when getting the posts the "oldest" one is returned first and assumed to be the "first reply"
  validates_presence_of :title
  validates_presence_of :body
  
end
