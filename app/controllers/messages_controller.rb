class MessagesController < ApplicationController
  def new
  	@message = Message.new
  end

 	def create
 		@message = Message.new(params[:message])
    if @message.save
    	ContactMailer.new_message(@message).deliver
    	flash[:success] = "Your message was sent successfully." +
    		" Please allow 24 hours for a response."
      redirect_to(root_path)
    else
      render 'new'
    end
  end

end
