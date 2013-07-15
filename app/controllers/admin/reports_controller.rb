class Admin::ReportsController < Admin::DashboardController

  inherit_resources

  belongs_to :user

  actions :all, :except => [:show]

  defaults :route_prefix => 'admin'

  def create
  	create!(:notice => "Счет/Отчет успешно создан")
    ReportMailer.delay.report_notification(resource)
	end

	def destroy
  	destroy!(:notice => "Счет/Отчет удален!")
	end

end