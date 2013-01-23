class ContactMailer < ActionMailer::Base

  default :from => "contact@appcontraption.com"
  default :to => "info@stonehen.com"

  def new_message(message)
    @message = message
    mail(
    	subject:"[appcontraption.com] #{message.subject}", 
    	from: message.email,
    	body: message.body)
  end

end