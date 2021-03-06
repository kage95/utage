class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :content, presence: true, length: { maximum: 255 }

  def template
    ApplicationController.renderer.render partial: 'messages/message', locals: { message: self }
  end
end
