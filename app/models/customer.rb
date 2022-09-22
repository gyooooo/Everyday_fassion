class Customer < ApplicationRecord
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :customer

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
    profile_image.variant( resize: "60x60^!", gravity: "center", crop: "60x60+0+0" )
  end
  
  # フォローする
  def follow(other_customer)
    unless self == other_customer
      self.relationships.find_or_create_by(follow_id: other_customer.id)
    end
  end
  
  # フォローを外す
  def unfollow(other_customer)
    relationship = self.relationships.find_by(follow_id: other_customer.id)
    relationship.destroy if relationship
  end
  
  # すでにフォローしているのか確認
  def following?(other_customer)
    self.followings.include?(other_customer)
  end
end