class Customer::CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_customer.comments.new(comment_params)
    comment.save
    redirect_to root_path(post)
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to root_path(params[:post_id])
  end

  private

  def comment_params
    params.permit(:body, :customer_id, :post_id)
  end
end
