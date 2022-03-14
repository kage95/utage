class Event < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  has_many :memberships, dependent: :destroy
  has_one :room, dependent: :destroy

  validates :event_name, presence: true, length: {minimum:10, maximum:30}
  validates :date, presence: true
  validates :limit, presence: true
  validates :detail, presence: true, length: {minimum:10, maximum:255}
end
