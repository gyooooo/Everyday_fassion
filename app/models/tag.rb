class Tag < ApplicationRecord
  has_many :tag_maps, foreign_key: 'tag_id'
  has_many :posts, through: :tag_maps, dependent: :destroy
end
