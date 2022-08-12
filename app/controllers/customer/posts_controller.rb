class Customer::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @post.save
    redirect_to root_path
  end

  def index
        #presentメソッドはデータが入ってるかどうかを識別するメソッド
    if (params[:post_id]).present?
      @post = Post.where(post_id: params[:post_id])
      #モデル.where(カラム名: params[:受け取る名前＊カラム名だとわかりやすい])
      #whereメソッドは指定した条件に当てはまるデータを全て取得してくれる
    else
      @posts = Post.all
    end


    # if (params[:post_name]).present?
    #   @post_name = params[:post_name]
    # else
    #   @post_name = "商品"
    # end

    # @genres = Genre.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post.customer == current_customer
      render "edit"
    else
      redirect_to customers_path
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
    flash[:notice] = "Post was successfully destroyed."
    redirect_to customer_posts_path
    else
    @posts = Post.all
    render :index
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました"
      redirect_to customer_post_path
    else
      @posts = Post.all
      render :edit
    end
  end
  
  def ranking
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) DESC').limit(3).pluck(:post_id))
    @posts = Post.order("created_at DESC")
  end
  
  private
   def post_params
    params.require(:post).permit(:introduction, :image)
   end
end