class NotificationMailer < ActionMailer::Base
  
	default :from => "\"YarTrans Logistic, site service\" <service@yartrans.ua>"

	def debt_warning(email)
	    mail(:to => email, :subject => "Предупреждение о задолженности.")
	end

end
