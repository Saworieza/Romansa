class ConvosController < ApplicationController
	before_action :authenticate_user!

  	def new
 	end
 	def create
    	recipients = User.where(id: conversation_params[:recipients])
    	conversation = current_user.send_message(recipients, conversation_params[:body], conversation_params[:subject]).conversation
    	flash[:success] = "Your message was successfully sent!"
    	redirect_to convo_path(conversation) #conversation created in line 8
  	end

    def reply
      current_user.reply_to_conversation(conversation, message_params[:body])
      flash[:notice] = "Your reply message was successfully sent!"
      redirect_to convo_path(conversation)
    end

  	def show
    	@receipts = conversation.receipts_for(current_user)
    	# mark conversation as read
    	conversation.mark_as_read(current_user)
  	end


  	private

  	def conversation_params
    	params.require(:convo).permit(:subject, :body,recipients:[])
  	end

    def message_params
      params.require(:message).permit(:body, :subject)
    end

end
