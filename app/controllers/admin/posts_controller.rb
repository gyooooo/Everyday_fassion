class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update!(post_params)
      redirect_to admin_post_path(@post), notice: "無事に更新されました"
    else
      render 'edit'
    end  
  end

  private
  def post_params
    params.require(:post).permit(:introduction, :tag_name, :is_active, :image)
  end
end
