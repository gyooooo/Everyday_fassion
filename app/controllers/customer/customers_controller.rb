class Customer::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer, only: [:followings, :followers]
  
  def new
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @posts = @customer.posts.all.order(created_at: :desc)
    @post_image = @customer.profile_image
  end

  def edit
    @customer = current_customer
    if @customer == current_customer
      render "edit"
    else
      redirect_to customer_customer_path(current_customer.id)
    end
  end

  def unsubscribe
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_customer_path
    else
      render "edit"
    end
  end
  
  def destroy
    @customer = Customer.find(params[:id])
  end
  
  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  def favorite
    @customer = Customer.find(params[:id])
    @favorite_posts = Post.where(id: @customer.favorites.pluck(:post_id))
  end
  
  def followings
    @customers = @customer.followings
  end

  def followers
    @customers = @customer.followers
  end
  
  private
    def customer_params
        params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :profile_image, :nickname)
    end
    
    def set_customer
     @customer = Customer.find(params[:id])
    end
    
  def correct_customer
    @customer = Customer.find(params[:id])
    @customer = @customer.new
    redirect_to(customers_path) unless @customer == current_customer
  end
end
