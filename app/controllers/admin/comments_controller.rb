class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @commment = Comment.find(params[:id])
  end
  
  def index
    @comments = Comment.all
  end
  
  def edit
  end
  
  def update
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
end