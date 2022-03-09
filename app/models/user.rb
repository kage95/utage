class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar


  def get_avatar
    unless avatar.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      avatar.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    avatar.variant(resize:"200x200").processed
  end
end
