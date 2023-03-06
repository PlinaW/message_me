class MessagesController < ApplicationController
  before_action :require_user

  def create
    message = current_user.messages.build(message_params)
    if message.save
      ActionCable.server.broadcast("chatroom_channel", {mod_message: message_render(message)})
      end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
  
  def message_render(message)
    render(partial: 'message', locals: {message: message})
  end

  #The {message: messsage} part is an argument to the render call, 
  #it is passing the message variable that's in scope here to the partial itself, 
  #where it will also be called message.
  #Without this code, there would be no variable called message available inside the partial.

end