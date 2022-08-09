class Post < ApplicationRecord
  belongs_to:customer
    def customer
       return Customer.find_by(id: self.customer_id)
    end
    
  has_one_attached :image
  belongs_to :customer
    
    def get_image
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
        image
    end
end
