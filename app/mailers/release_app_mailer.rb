class ReleaseAppMailer < ActionMailer::Base

  require 'app_file_generator'

  default from: "\"YarTrans Logistic, site service\" <service@yartrans.ua>"

  def new_app_to_manager(app)
    @app = app
    
    file_name = AppFileGenerator.release_file_name(app)
  
    if app.file_url.blank?
      attachments[file_name] = AppFileGenerator.render_release_xlsx_file(app).to_stream.read
    else
      attachments["UP_"+file_name] = File.read('public/'+app.file_url)
    end

    mail_to = SiteSettings["release_apps.manager_email"]
    subject = t(:"applications.release.mailer.new_app.to_manager.subject", :client => app.user.profile.name)
    mail(:to => mail_to, :subject => subject, :from => "\"#{app.user.profile.name} (#{app.user.profile.personal_id})\" <service@yartrans.ua>")
  end

  def new_app_to_client(app)
    
    @app = app

    file_name = AppFileGenerator.release_file_name(app)
   
    if app.file_url.blank?
      attachments[file_name] = AppFileGenerator.render_release_xlsx_file(app).to_stream.read
    else
      attachments["UP_"+file_name] = File.read('public/'+app.file_url)
    end

    mail_to = app.user.email
    mail_to += ', ' + app.user.profile.alt_email if app.user.profile.alt_email.present?
    mail_to += ', ' + app.staff.email if app.staff.present?

    subject = t(:"applications.release.mailer.new_app.to_client.subject")
    mail(:to => mail_to, :subject => subject)

  end

end

