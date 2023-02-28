class Room < ApplicationRecord
  validates :name, presence: true
  has_many :user_rooms
  has_many :users, through: :user_rooms
  has_many :messages

  after_update_commit :update_room_details

  private

  def update_room_details
    broadcast_replace_to('room_details_channel', partial: 'shared/room', locals: {room: self}, target: "room_#{id}")
  end
end
