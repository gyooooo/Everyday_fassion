class Post < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :genres, dependent: :destroy
   
    def customer
       return Customer.find_by(id: self.customer_id)
    end
    
  has_one_attached :image
  belongs_to :customer
  
  
  validates :image, presence: true

    def self.search(search)
      return Post.all unless search
      Post.where('introduction LIKE(?)', "%#{search}%")
    end
    
    def get_image
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
        image
    end
    
    def save_tag(sent_tags)
       current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
       old_tags = current_tags - sent_tags
       new_tags = sent_tags - current_tags
  
       old_tags.each do |old|
         self.tags.delete Tag.find_by(tag_name: old)
       end
  
       new_tags.each do |new|
         new_post_tag = Tag.find_or_create_by(tag_name: new)
         self.tags << new_post_tag
       end
    end
      
    def favorited_by?(customer)
      favorites.where(customer_id: customer.id).exists?
    end
end