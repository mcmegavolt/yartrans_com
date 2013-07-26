class Admin::AdmissionAppsController < Admin::DashboardController

	inherit_resources

	# actions :all, :except => [ :show ]

  def update
    update!(:notice => "Admission app was updated!")
  end

  def destroy
    destroy!(:notice => "Admission app was deleted!")
  end

end
