class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  
  validates :body, presence: true, length: { maximum: 1000 }
end
