class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, length: {minimum:2, maximum:10}
  validates :email, presence: true, length: { maximum: 255 }
  validates :comment, presence: true, length: {in: 1..255}

  has_one_attached :avatar
  has_many :planning_events,class_name: "Event",
                            foreign_key: "user_id", 
                            dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :events, through: :memberships

  def get_avatar(size)
    unless avatar.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      avatar.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    avatar.variant(gravity: :center, resize: size, crop:"250x250+0+0").processed
  end
end
