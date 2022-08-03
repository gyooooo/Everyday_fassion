class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # def self.guest
  #   find_or_create_by!(email: 'guest@test.com') do |user|
  #     user.password = SecureRandom.urlsafe_base64 # ランダムなパスワードを生成
  #   end
  # end
  
  def self.guest
    find_or_create_by!(email: 'guest@test.com', last_name: 'guest', first_name: 'guest') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end
end
