class ConvosController < ApplicationController
	before_action :authenticate_user!

  	def new
 	end
 	def create
    	recipients = User.where(id: conversation_params[:recipients])
    	conversation = current_user.send_message(recipients, conversation_params[:body], conversation_params[:subject]).convo
    	flash[:success] = "Your message was successfully sent!"
    	redirect_to convo_path(convo)
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

end
