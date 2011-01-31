class Post < ActiveRecord::Base
  belongs_to :comment
  has_ancestry
  validates_presence_of :body
  
end
