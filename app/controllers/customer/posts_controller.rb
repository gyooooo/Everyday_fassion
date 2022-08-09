class Customer::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @post.save
    redirect_to root_path
  end

  def index
    @posts = Post.all
    # @post_images = Post.new(params[:id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end
  
  private
   def post_params
    params.require(:post).permit(:introduction, :image)
   end
end
