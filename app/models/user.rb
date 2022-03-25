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
  has_many :favorites, dependent: :destroy
  has_many :favorite_events, through: :favorites,
                             source: :event,
                             foreign_key: "user_id",
                             dependent: :destroy

  def get_avatar(size)
    unless avatar.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      avatar.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    avatar.variant(gravity: :center, resize: size, crop:"250x250+0+0").processed
  end
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "ゲストユーザー"
      user.comment = "ゲストログインしています"
    end
  end
  
  def update_without_current_password(params)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank? 
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update(params)
    clean_up_passwords
    result
  end
end
