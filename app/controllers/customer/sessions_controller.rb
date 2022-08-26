# frozen_string_literal: true

class Customer::SessionsController < Devise::SessionsController
  
  before_action :find_deleted_customer, only: [:create]
  
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path
  end

  def find_deleted_customer
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
      if @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == true)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_customer_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end
end
