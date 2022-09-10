class Tag < ApplicationRecord

  has_many :posts

  validates :name, presence: true, length: { maximum: 10 }

end
