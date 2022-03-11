class Event < ApplicationRecord
  belongs_to :restaurant

  validates :event_name, presence: true, length: {minimum:10, maximum:30}
  validates :date, presence: true
  validates :limit, presence: true
  validates :detail, presence: true, length: {minimum:10, maximum:255}
end
