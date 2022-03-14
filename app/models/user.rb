class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, length: {minimum:2, maximum:10}
  validates :email, presence: true, length: { maximum: 255 }
  validates :comment, presence: true, length: {in: 1..255}

  has_one_attached :avatar
  has_many :events, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :messages, dependent: :destroy

  def get_avatar
    unless avatar.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      avatar.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    avatar.variant(gravity: :center, resize:"250x250^", crop:"250x250+0+0").processed
  end
end
