class NewsItemMailer < ActionMailer::Base
  
	default :from => "\"YarTrans Logistic, site service\" <service@yartrans.ua>"

  def news_item_notification(news_item, email)

  	@news_item = news_item
  	
    subject = 'Корпоративные новости. Личный кабинет на Yartrans.ua'
    
    # Get all client users
    # Role.find_by_name("Client").users.map(&:email)

   	mail(:to => email, :subject => subject)

  end

end
