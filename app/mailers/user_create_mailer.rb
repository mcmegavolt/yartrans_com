class UserCreateMailer < ActionMailer::Base
  default from: "\"YarTrans Logistic, site service\" <service@yartrans.ua>"

  def user_welcome(user,password)
  	
  	@user = user
  	@password = password

  	mail_to = user.email
    subject = 'Личный кабинет на Yartrans.ua'
    mail(:to => mail_to, :subject => subject)

  end

end
