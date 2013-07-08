class ReportMailer < ActionMailer::Base
  
	default :from => "\"YarTrans Logistic, site service\" <service@yartrans.ua>"

  def report_notification(report)

  	@report = report

    subject = 'Отчет о проделанной работе. Личный кабинет на Yartrans.ua'
    content_type = "multipart/mixed"
    
	attachments[File.basename(report.file.path)] = File.read(report.file.path)

   	mail(:to => report.user.email, :subject => subject)

  end

end