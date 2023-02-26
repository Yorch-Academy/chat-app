class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # after_create_commit :broadcast_rooms_create

  private

  # def broadcast_rooms_create
  #   broadcast_append_to(@,partial: 'sidebar/single_room',locals: {room: Room.find(room_id)},target: "user_#{user_id}_rooms")
  # end
end
