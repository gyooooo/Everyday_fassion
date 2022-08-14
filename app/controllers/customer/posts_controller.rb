class Customer::PostsController < ApplicationController
  # def new
  #   @post = Post.new
  # end
  
  def new
    @post = Post.new
    @post = current_customer.posts.new
  end
  
  # def create
  #   @post = Post.new(post_params)
  #   @post.customer_id = current_customer.id
  #   @post.save
  #   redirect_to root_path
  # end
  
  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    tag_list = params[:post][:tag_name].split(nil)  
    if @post.save
      @post.save_tag(tag_list)                                                           
      redirect_to customer_posts_path
    else
      redirect_to new_customer_post_path
    end
  end

  def index
    #presentメソッドはデータが入ってるかどうかを識別するメソッド
    if (params[:post_id]).present?
      @post = Post.where(post_id: params[:post_id])
      #モデル.where(カラム名: params[:受け取る名前＊カラム名だとわかりやすい])
      #whereメソッドは指定した条件に当てはまるデータを全て取得してくれる
    else
      @posts = Post.all
      @tag_list = Tag.all
    end
    # if (params[:post_name]).present?
    #   @post_name = params[:post_name]
    # else
    #   @post_name = "商品"
    # end

    # @genres = Genre.all
  end

  def show
    if params[:id] != "search" then
      @post = Post.find(params[:id])
    end
    @posts = Post.search(params[:keyword])
    @comment = Comment.new
    @post_tags = @post.tags
  end

  def edit
    @tag_list=@post.tags.pluck(:tag_name).join(nil)
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
    tag_list = params[:post][:tag_name].split(nil)
    # もしpostの情報が更新されたら
    if post.update(post_params)
      # このpost_idに紐づいていたタグを@oldに入れる
      old_relations = TagMap.where(post_id: post.id)
      # それらを取り出し、消す。
      old_relations.each do |relation|
        relation.delete
      end
      post.save_tag(tag_list)
      redirect_to post_path(post.id), notice:'投稿完了しました:)'
    else
      redirect_to :action => "edit"
    end
        
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
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) DESC').limit(3).pluck(:post_id))
    @posts = Post.order("created_at DESC")
    #順番を並び替える
  end
  
  # def search
  #   @posts = Post.search(params[:keyword])
  # end

  def search
    @posts = Post.search(params[:keyword])
    @tag_list = Tag.all               # こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  # クリックしたタグを取得
    @posts = @tag.posts.all
  end
  
protected
  def post_params
    params.require(:post).permit(:introduction, :image, :customer_id)
  end
end
