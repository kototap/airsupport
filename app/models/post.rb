class Post < ApplicationRecord

  belongs_to :user
  belongs_to :tag
  has_many :bookmarks, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_one_attached :post_image


  # with_options presence: true, on: :publicize do
  #   validates :post_image
  #   validates :title, length: { maximum: 20 }
  #   validates :body, length: { maximum: 80 }
  #   validates :airport
  #   validates :tag_id
  # end



  def get_post_image(width, height)
  unless post_image.attached?
    file_path = Rails.root.join('app/assets/images/no_post_image.png')
    post_image.attach(io: File.open(file_path), filename: 'no_post_image.png', content_type: 'image/png')
  end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  # ブックマークがあるか
  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end
end
