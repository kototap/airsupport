class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :post_comments, dependent: :destroy

    validates :name, presence: true, length: { maximum: 10 }
    validates :email, presence: true



  # ゲストログイン
  def self.guest
    find_or_create_by!(name: "guestuser", email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end



  # プロフィール画像
  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/javascript/images/no_image.png")
      profile_image.attach(io: File.open(file_path), filename: "no_image.png", content_type: "image/png")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
