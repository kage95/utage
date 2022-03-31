class Restaurant < ApplicationRecord
  has_many :events

  validates :name, presence: true
  validates :address, presence: true
  validates :catch, presence: true
  validates :url, presence: true
  validates :image_url, presence: true
end
