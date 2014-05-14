class PostsController < ApplicationController

  def index
    if user_signed_in?
      @posts = Post.all
    else
      redirect_to "root_path"
    end
  end

  def new
    @post = Post.new 
  end

  def create
    # binding.pry
    @post = Post.create(post_params)
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
      @post= Post.find(params[:id])
      if @post.update(post_params)
        redirect_to @post, notice: 'Post was successfully updated.'
      else
       render action: 'edit'
      end 
  end

  def show
    @post = Post.find(params[:id])  
    @comment = Comment.new
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :body, :comments_attributes=>[:body])
  end

end
