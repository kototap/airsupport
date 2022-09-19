class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :comment, length: { maximum: 50 }, presence: true
end
