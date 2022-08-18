class Customer::TagsController < ApplicationController
  def show
    tag = Tag.find(params[:id])
    @posts = tag.posts
    # @posts = Post.where(tag_id: params[:id])
  end

# protected
#   def tag_params
#     params.require(:post).permit(:introduction, :image, :customer_id, :tag_id)
#   end
end