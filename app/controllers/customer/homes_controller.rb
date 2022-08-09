class Customer::HomesController < ApplicationController
  # before_action :set_post, only[:post_index, :edit, :update, :destroy]
  def top
  end

  def about
  end
  
  # def post_index
  # @customer = @post.user
  # @posts = @customer.posts
  # end
  
  # private
  #   #Post.find_by(id: params[:id])はよく使うので定義しといてbefore_actionで反映。
  #   def set_post
  #     @post = Post.find_by(id: params[:id])
  #   end
end
