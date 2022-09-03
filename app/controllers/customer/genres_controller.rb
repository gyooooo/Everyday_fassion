class Customer::GenresController < ApplicationController
  def show
    genre = Genre.find(params[:id])
    api_genre_id = Genre.where(name: genre.name).pluck(:post_id)
    @posts = Post.where(id: api_genre_id).order(created_at: :desc)
  end
end
