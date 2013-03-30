class Cabinet::ReleaseAppsController < Cabinet::DashboardController
  
  def index
    authorize! :read, ReleaseApp
  end

  def show
    authorize! :read, ReleaseApp
  end

  def new
    authorize! :create, ReleaseApp
    release_app.release_items.build
  end

  def create
    authorize! :create, ReleaseApp

    release_app.user = current_user
    if release_app.save

      ReleaseAppMailer.new_app_to_manager(release_app).deliver 
      ReleaseAppMailer.new_app_to_client(release_app).deliver

      flash[:success] = t(:'applications.release.flash.created')
      redirect_to cabinet_release_apps_path
    else
      flash[:error] = t(:'applications.release.flash.not_created')
      render :action => "new"
    end
  end

  def edit
    authorize! :edit, ReleaseApp
  end

  def update
    
    authorize! :edit, ReleaseApp

    if release_app.update_attributes(params[:release_app])
      flash[:success] = t(:'applications.release.flash.updated')
      redirect_to cabinet_release_apps_path
    else
      flash[:success] = t(:'applications.release.flash.not_updated')
      render "edit"
    end
  end

  def destroy
    authorize! :destroy, ReleaseApp

    if release_app.destroy
      flash[:success] = t(:'applications.release.flash.destroyed')
      redirect_to cabinet_release_apps_path
    end
  end

  def release_apps
    @release_apps ||= if params[:id]
      			    else
                    @release_apps = current_user.release_apps.page params[:page]
			          end
  end
  helper_method :release_apps

  def release_app
    @release_app ||= if params[:id]
      ReleaseApp.find(params[:id])
    else
      ReleaseApp.new(params[:release_app])
    end
  end
  helper_method :release_app

end
