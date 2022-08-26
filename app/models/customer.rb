class Customer < ApplicationRecord
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def self.guest
    find_or_create_by!(email: 'guest@test.com', last_name: 'guest', first_name: 'guest') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/image10.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end