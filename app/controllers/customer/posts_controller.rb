class Customer::PostsController < ApplicationController

  def new
    @post = Post.new
    @post = current_customer.posts.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    tag_list = params[:post][:tag_name].split(/[[:blank:]]+/)
    
    if @post.save
      # APIのタグ機能
      genres = Vision.get_image_data(@post.image)    
      genres.each do |genre|
      @post.genres.create(name: genre)
      end
      
      @post.save_tag(tag_list)                                                           
      redirect_to customer_posts_path
    else
      render :new
    end
  end

  def index
    #presentメソッドはデータが入ってるかどうかを識別するメソッド
    if (params[:tag_id]).present?
      @posts = Post.where(tag_id: params[:tag_id])
      #モデル.where(カラム名: params[:受け取る名前＊カラム名だとわかりやすい])
      #whereメソッドは指定した条件に当てはまるデータを全て取得してくれる
    else
      @posts = Post.all.order(created_at: :desc)
    end
  end

  def show
    if params[:id] != "search" then
      @post = Post.find(params[:id])
    end
    @posts = Post.search(params[:keyword])
    @comment = Comment.new
    @post_tags = @post.tags
  end
  
  def follow
    @customer = Customer.find(current_customer.id)
    @custoemrs = @customer.followings
    @posts = []
    
    if @customers.present?
    @customers.each do |customer|
    following_customer_posts = Post.where(customer_id: customer.id).order(created_at: :desc)
    current_customer_posts = Post.where(customer_id: current_customer.id).order(created_at: :desc)
    #取得したユーザーの投稿一覧を@postsに格納
    @posts.concat(following_customer_posts)
    @posts.concat(current_customer_posts)
    end
    #@postsを新しい順に並べたい
    @posts.sort_by!{|post| post.created_at}.reverse!
    if @posts.nil?
      flash[:notice]="もっとたくさんの仲間をフォローしましょう！"
      end
      else
      flash[:notice]="誰かをフォローしてみましょう！"
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.customer == current_customer
      render "edit"
    else
      redirect_to customer_customer_path
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
    tag_list = params[:post][:tag_name].split(nil)
    # もしpostの情報が更新されたら
    if @post.update(post_params)
      @post.save_tag(tag_list)
      @post.genres = []
      genres = Vision.get_image_data(@post.image)    
      genres.each do |genre|
        @post.genres.create(name: genre)
      end
      
      redirect_to customer_post_path(@post.id), notice:'投稿完了しました:)'
    else
      redirect_to :action => "edit"
    end
  end
  
  def genre
    @post = Post.find(params[:id])
  end
  
  def tag
    @post = Post.find(params[:id])
  end

  def ranking
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) DESC').pluck(:post_id))
  end

  def search
    if params[:keyword] != nil
      @posts = Post.search(params[:keyword]).order(created_at: :desc)
    elsif params[:tag_id] != nil
      @tag_list = Tag.all
      # こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
      @tag = Tag.find(params[:tag_id])
      # クリックしたタグを取得
      @posts = @tag.posts.all.order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
  end
  
protected
  def post_params
    params.require(:post).permit(:introduction, :image, :customer_id, :tag_id)
  end
end
