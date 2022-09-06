class Post < ApplicationRecord

  belongs_to :user
  belongs_to :tag
  has_many :bookmearks, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_one_attached :post_image

  def get_post_image(width, height)
  unless post_image.attached?
    file_path = Rails.root.join('app/assets/images/no_post_image.png')
    post_image.attach(io: File.open(file_path), filename: 'no_post_image.png', content_type: 'image/png')
  end
    post_image.variant(resize_to_limit: [width, height]).processed
  end
end
