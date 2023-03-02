class MessagesController < ApplicationController
  before_action :set_room, only: %i[create edit]
  before_action :set_message, only: %i[edit update destroy]

  def create
    @message = @room.messages.new message_params
    @message.user = current_user

    respond_to do |format|
      if @message.save
        format.turbo_stream
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @message.update message_params
        format.turbo_stream
      end
    end
  end

  def destroy
    @message.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:message)
  end
end
