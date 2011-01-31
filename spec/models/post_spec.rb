require 'spec_helper'

describe Post do
  def comment(attributes = {})
    attrs = {:title => "Title", :body => "This is a body"}
    @comment = Comment.create!(attrs.merge!(attributes))
  end
  it "should belong to a comment" do
    post = comment.posts.build(:body => "Response", :name => "Jay")
    post.comment_id.should == @comment.id
  end
  it "should also be allowed to have a parent" do
    post = comment.posts.create(:body => "Response", :name => "Jay")
    
    child = post.children.create(:body =>"Response to response", :name => "Adam")
    child.save!
    
    child.parent.name.should == "Jay"
    
  end
  it "should have children" do
    post = comment.posts.create(:body => "Response", :name => "Jay")
    
    child = post.children.create(:body =>"Response to response", :name => "Adam")
    child.save!
    child2 = post.children.create(:body =>"Response to response etc", :name => "Matt")
    child2.save!
    
    child.parent.name.should == "Jay"
    post.children.length.should == 2
  end
end
 