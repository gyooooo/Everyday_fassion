class Customer::TagsController < ApplicationController
  def show
    @posts = Post.where(tag_id: params[:tag_id])
  end

# protected
#   def tag_params
#     params.require(:post).permit(:introduction, :image, :customer_id, :tag_id)
#   end
end