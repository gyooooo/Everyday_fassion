class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def show
    # @commment = Comment.find(params[:id])
  end
  
  def index
    # @comments = Comments.all
  end
  
  def edit
    # @comment = Comment.find(params[:id])
  end
  
  def update
    # @comment = Comment.find(params[:id])
    # @comment.update(comment_params)
    # redirect_to admin_comment_path(@comment.id)
  end

  private

  # def comment_params
  #   params.require(:comment).permit(:comment, :comment_status)
  # end
end
