class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit :broadcast_room_messages_create

  private

  def broadcast_room_messages_create
    broadcast_append_to('room_messages_channel', partial: 'messages/message', locals: {message: self}, target: "room_messages_div")
  end
end
