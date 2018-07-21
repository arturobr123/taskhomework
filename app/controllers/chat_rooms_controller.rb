class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:show]
  before_action :check_user_admin, only: [:show]


  def index
    @chat_rooms = ChatRoom.all
  end

  def new
    @chat_room = ChatRoom.new
  end

  def show
    #@chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    if @chat_room.save
      redirect_to chat_rooms_path , notice: "Chat room added!"
    else
      render 'new'
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end

  def set_chat_room
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
  end

  #verificar que estudiante y e trabajador sean los mismos que los del salon
  def check_user_admin
    if current_user
      if @chat_room.user_id == current_user.id
        return true
      end
    end

    if current_admin
      if @chat_room.admin_id == current_admin.id
        return true
      end
    end

    redirect_to root_path, notice: "No estas autorizado"
  end


end
