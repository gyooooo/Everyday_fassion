class Customer::RelationshipsController < ApplicationController
  before_action :set_customer, only: [:create, :destroy]
  
  def create
    current_customer.follow(@customer)
    flash[:success] = 'ユーザーをフォローしました'
    redirect_back(fallback_location: root_url)
  end

  def destroy
    current_customer.unfollow(@customer)
    flash[:success] = 'ユーザーのフォローを解除しました'
    redirect_back(fallback_location: root_url)
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
