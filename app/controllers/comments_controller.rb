class CommentsController < ApplicationController

  def index
    if (params[:sort] == "activity")
      @sort = "activity"
      @comments = Comment.find_by_sql("select c.*, count(*) as num from comments as c left join posts as p on c.id=p.comment_id Group By p.comment_id order by num DESC")
    else
      @comments = Comment.all #default sort by date
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @root_post = @comment.posts[0] if @comment.posts.length > 0

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@comment, :notice => 'Comment was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
    end
  end
end
