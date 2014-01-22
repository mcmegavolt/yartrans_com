class FeedbackMailer < ActionMailer::Base

	default :from => "\"YarTrans Logistic, site service\" <service@yartrans.ua>"
  default to: SiteSettings["feedback.email"]

  def feedback(feedback)
    @feedback = feedback
    mail(:subject => 'Форма обратного звонка')
  end

end

