class Admin::ReleaseAppsController < Admin::DashboardController

	inherit_resources

	# actions :all, :except => [ :show ]

  def update
    update!(:notice => "Release app was updated!")
  end

  def destroy
    destroy!(:notice => "Release app was deleted!")
  end

  def process_app
    if resource.process_app!
      flash[:success] = t(:'admin.release_apps.flash.processing')
      redirect_to admin_release_apps_path
    else
      flash[:error] = t(:'admin.release_apps.flash.error')
      redirect_to admin_release_apps_path
    end
  end

  def complete_app
    if resource.complete_app!
      flash[:success] = t(:'admin.release_apps.flash.completed')
      redirect_to admin_release_apps_path
    else
      flash[:error] = t(:'admin.release_apps.flash.error')
      redirect_to admin_release_apps_path
    end
  end

  def stop_app
    if resource.stop_app!
      flash[:success] = t(:'admin.release_apps.flash.stoped')
      redirect_to admin_release_apps_path
    else
      flash[:error] = t(:'admin.release_apps.flash.error')
      redirect_to admin_release_apps_path
    end
  end

  protected
  
    def collection
        @release_apps ||= ReleaseApp.with_state(params[:state].present? ? params[:state] : :pending).page params[:page]
    end

end
