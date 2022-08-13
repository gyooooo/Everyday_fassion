class Customer::FavoritesController < ApplicationController
  
  def create
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: post.id)
    favorite.save
    redirect_to customer_post_path(post)
    
    # @favorite = current_customer.favorites.create(post_id: params[:post_id])
    # redirect_back(fallback_location: root_path)
  end
  
  def destroy
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to customer_post_path(post)
    
    # @post = Post.find(params[:post_id])
    # @favorite = Favorite.find_by(post_id: @post.id)
    # @favorite.destroy
    # redirect_back(fallback_location: root_path)
  end
end
