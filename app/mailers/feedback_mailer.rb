class FeedbackMailer < ActionMailer::Base

	default :from => "\"YarTrans Logistic, site service\" <service@yartrans.ua>"

  def feedback(feedback)
    @feedback = feedback
    mail(:to => SiteSettings["feedback.email"], :subject => 'Форма обратного звонка')
  end

end

