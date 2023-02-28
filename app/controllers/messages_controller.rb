class MessagesController < ApplicationController
  before_action :set_room, only: %i[create]

  def create
    @message = @room.messages.new message_params
    @message.user = current_user

    respond_to do |format|
      if @message.save
        format.turbo_stream
      end
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:message)
  end
end
