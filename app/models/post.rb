class Post < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
   
    def customer
       return Customer.find_by(id: self.customer_id)
    end
    
  has_one_attached :image
  belongs_to :customer
  
  # validates :title, presence: true

# 　validates :introduction, presence: true, length: {maximum: 200}
    
    def get_image
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
        image
    end
    
    def favorited_by?(customer)
      favorites.where(customer_id: customer.id).exists?
    end
end