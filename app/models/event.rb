class Event < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to_active_hash :prefecture
  belongs_to :restaurant
  belongs_to :planning_user, class_name: "User", foreign_key: "user_id"

  has_one :room, dependent: :destroy

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  
  has_one_attached :event_image

  validates :event_name, presence: true, length: {minimum:10, maximum:30}
  validates :date, presence: true
  validates :limit, presence: true
  validates :detail, presence: true, length: {minimum:10, maximum:255}

  scope :search, -> (event_search_params) do
    return if event_search_params.blank?

    event_name_like(event_search_params[:event_name])
      .date_like(event_search_params[:date].to_date)
  end

  scope :event_name_like, -> (event_name) { where('event_name LIKE ?', "%#{event_name}%") if event_name.present? }
  scope :date_like, -> (date) { where("date >= ? AND date < ?", date, date + 1) if date.present? }
  
  def get_image
    @image = "image#{rand(1..5)}.jpg"
    file_path = Rails.root.join("app/assets/images/#{@image}")
    event_image.attach(io: File.open(file_path), filename: "default-image.jpg")
  end
end
