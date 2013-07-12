class ReportMailer < ActionMailer::Base
  
	default :from => "\"YarTrans Logistic, site service\" <service@yartrans.ua>"

  def report_notification(report)

  	@report = report

    # subject = 'Отчет о проделанной работе. Личный кабинет на Yartrans.ua'
    subject = 'Счет за услуги. Личный кабинет на Yartrans.ua'
    content_type = "multipart/mixed"
    
	attachments[File.basename(report.file.path)] = File.read(report.file.path)

	mail_to = report.user.email

    if report.user.profile.alt_email.present?
      mail_to += ', ' + report.user.profile.alt_email
    end

   	mail(:to => mail_to, :subject => subject)

  end

end