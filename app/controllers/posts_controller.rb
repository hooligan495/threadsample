class PostsController < ApplicationController
  before_filter :find_comment
  respond_to :html

  def index
    @posts = @comment.posts
    respond_with(@posts)
  end

  def create
    unless params[:parent_id].blank?
      @parent_post = Post.find(params[:parent_id])
      @post = @parent_post.children.create!(params[:post])
      @comment.posts << @post
    else
      @post = @comment.posts.create!(params[:post])
    end    
    @comment.updated_at = Time.now
    @comment.save!
    respond_with(@comment)
  end

  #if we destroy a post we lose it's children or we could change the body of the post to "removed" in order to still preserve the 
  #child comments
  def destroy
    @post = Post.find(params[:id])
    @post.body = "Comment Removed"
    @post.save
    @post.comment.updated_at = Time.now
    @post.comment.save!
    respond_with(@comment)
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      @post.comment.updated_at = Time.now
      @post.comment.save!
      respond_with(@comment)
    else
      respond_with(@post, :location => edit_post_path(@post))
    end
  end

  def new
    @parent_id = params[:parent_id] unless params[:parent_id].blank?
    @post = @comment.posts.build()
    respond_with(@post)
  end

  def edit
    @post = @comment.posts.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
    respond_with(@post)
    
  end
  private 
  def find_comment
    @comment = Comment.find(params[:comment_id]) if params[:comment_id]    
  end

end
