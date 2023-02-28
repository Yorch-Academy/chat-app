class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  def index
    @rooms = Room.all
  end

  def show
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        UserRoom.create(room: @room, user: current_user)
        format.turbo_stream { render turbo_stream: turbo_stream.append("user_#{current_user.id}_rooms", partial: 'shared/room', locals: { room: @room }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("room_form", partial: 'rooms/form', locals: { room: @room, title: 'Create new room' }) }
      end
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("room_#{@room.id}", partial: 'shared/room', locals: { room: @room }) }
      else
        format.html { render :edit }
        # format.turbo_stream { render turbo_stream: turbo_stream.replace("room_#{@room.id}", partial: 'rooms/form', locals: { room: @room, title: 'Edit room' }) }
      end
    end
  end

  def destroy
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
    end
  end

  def add_user
    UserRoom.create(room_id: params[:room_id], user_id: params[:user_id])

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("room_show_#{params[:room_id]}", partial: 'rooms/room', locals: { room: Room.find(params[:room_id]) }) }
    end
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:name)
    end
end
