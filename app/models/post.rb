class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :bookmarks, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_one_attached :post_image

  geocoded_by :address
  after_validation :geocode

  scope :latest, -> { order(created_at: :desc) }
  scope :draft, -> { where(is_draft: true) }
  scope :release, -> { where(is_draft: false) }


  with_options presence: true, on: :publicize do
    validates :title
    validates :body
    validates :airport
  end

  validates :title, length: { maximum: 20 }, on: :publicize
  validates :body, length: { maximum: 80 }, on: :publicize


  def get_post_image
    unless post_image.attached?
      file_path = Rails.root.join("app/javascript/images/no_post_image.png")
      post_image.attach(io: File.open(file_path), filename: "no_post_image.png", content_type: "image/png")
    end
    post_image
  end

  # ブックマークがあるか
  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end
end
