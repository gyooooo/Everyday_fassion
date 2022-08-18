class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @commment = Comment.find(params[:id])
  end
  
  def index
    @comments = Comment.all
  end
  
  def edit
    # @comment = Comment.find(params[:id])
  end
  
  def update
    # @comment = Comment.find(params[:id])
    # @comment.update(comment_params)
    # redirect_to admin_comment_path(@comment.id)
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "Comment was successfully destroyed."
      redirect_to admin_comments_path
    else
      @comments = Comment.all
      render 'index'
    end
  end

  private

  # def comment_params
  #   params.require(:comment).permit(:comment, :comment_status)
  # end
end