class Admin::ReportsController < Admin::DashboardController

  inherit_resources

  belongs_to :user

  actions :all, :except => [:show]

  defaults :route_prefix => 'admin'

  def create
  	create!(:notice => "Отчет успешно создан")
	end

	def destroy
  	destroy!(:notice => "Отчет удален!")
	end

end