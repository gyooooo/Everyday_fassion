class Customer::RelationshipsController < ApplicationController
  before_action :set_customer, only: [:create, :destroy]
  
  def create
    following = current_customer.follow(@customer)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to customer_customer_path(@customer)
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to customer_customer_path(@customer)
    end
  end

  def destroy
    following = current_customer.unfollow(@customer)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to customer_customer_path(@customer)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to customer_customer_path(@customer)
    end
  end
  
  def followings
    @user = Customer.find(params[:id])
    @customers = @user.followings
  end

  def followers
    @user = Customer.find(params[:id])
    @customers = @user.followers
  end

  private
  def set_customer
    @customer = Customer.find(params[:follow_id])
    # @user = Customer.find(params[:id])
  end
end
