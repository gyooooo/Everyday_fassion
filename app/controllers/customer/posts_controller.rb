class Customer::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to root_path
  end

  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end
  
  private
   def post_params
    params.require(:post).permit(:introduction, :image)
   end
end
