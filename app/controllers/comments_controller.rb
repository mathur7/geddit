class CommentsController < ApplicationController
  before_filter :load_post

  def index
    @comments = @post.comments.all
    @user = current_user
  end

  def show
    @comment = @post.comments.find(params[:id])
  end

  def new
    @comment = @post.comments.new
    @comment = User.find(params[:user_id]).comments.new(params[:comment])
  end

  def edit
    @comment = @post.comments.find(params[:id])
  end

  def create
    @comment = @post.comments.new(comment_params)
    if @comment.save
      redirect_to post_comments_path(@post)
    else
      render 'new'
    end
  end

  def update
    @comment= @post.comments.find(params[:id])
      if @comment.update(comment_params)
        redirect_to [@post, @comment], notice: 'Comment was successfully updated.'
      else
       render action: 'edit'
      end
  end

  def destroy
    @comment= @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_comments_path(@post)
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def load_post
    @post = Post.find(params[:post_id])
  end

end
