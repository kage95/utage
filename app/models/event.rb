class Event < ApplicationRecord
  belongs_to :restaurant
  belongs_to :planning_user, class_name: "User", foreign_key: "user_id"

  has_one :room, dependent: :destroy
  
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :event_name, presence: true, length: {minimum:10, maximum:30}
  validates :date, presence: true
  validates :limit, presence: true
  validates :detail, presence: true, length: {minimum:10, maximum:255}
  
  scope :search, -> (event_search_params) do
    return if event_search_params.blank?
    
    event_name_like(event_search_params[:event_name])
  end
  
  scope :event_name_like, -> (event_name) { where('event_name LIKE ?', "%#{event_name}%") if event_name.present? }
end
