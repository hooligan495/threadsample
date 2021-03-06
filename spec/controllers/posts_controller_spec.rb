require 'spec_helper'

describe PostsController do

  def mock_comment(stubs={})
    @mock_comment ||= mock_model(Comment, stubs)
  end
  
  def mock_post(stubs ={}) 
    @mock_post ||= mock_model(Post, stubs)
  end
  def mock_parent_post(stubs ={}) 
    @mock_post ||= mock_model(Post, stubs)
  end

  
  describe "POST 'create'" do
    it "should create a first post" do
      Comment.stub(:find).with(1) {mock_comment}
      x = mock("builder")
      mock_comment.should_receive(:posts).and_return(x)
      x.should_receive("create!").and_return(mock_post)      
      mock_comment.should_receive(:updated_at=)
      mock_comment.should_receive(:save!)
      post 'create', :comment_id=> 1, :post => {:body => "Post body", :name => "Poster"}
      response.should be_redirect
    end
    it "should create a child post" do
      Comment.stub(:find).with(1) {mock_comment}
      x = mock("builder")
      mock_comment.should_receive(:posts).and_return(x)
      Post.should_receive("find").and_return(mock_parent_post)
      mock_parent_post.should_receive("children").and_return(x)
      x.should_receive("create!").and_return(mock_post)      
      x.should_receive("<<")
      mock_comment.should_receive(:updated_at=)
      mock_comment.should_receive(:save!)
      post 'create', :comment_id=> 1, :parent_id => 1, :post => {:body => "Post body", :name => "Poster"}
      response.should be_redirect
      
    end
  end
  
  describe "GET 'new'" do
    it 'should get the new post page for a comment' do
      Comment.stub(:find).with(1) {mock_comment}
      x = mock("builder")
      mock_comment.should_receive(:posts).and_return(x)
      x.should_receive(:build).and_return(mock_post)
      get 'new', :comment_id => 1
      response.should be_success
    end
    
    it "should get the new post page for a comment with a post as a parent" do
      Comment.stub(:find).with(1) {mock_comment}
      x = mock("builder")
      mock_comment.should_receive(:posts).and_return(x)
      x.should_receive(:build).and_return(mock_post)
      get 'new', :comment_id => 1, :parent_id => 3
      response.should be_success      
    end
  end


end
