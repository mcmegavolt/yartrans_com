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

    unless release_app.file.blank?
      release_app.release_items.destroy_all
    end

    if release_app.save

      ReleaseAppMailer.delay.new_app_to_manager(release_app)
      # ReleaseAppMailer.delay.new_app_to_client(release_app)

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

  def download_sample
    require 'app_file_generator'
    send_data AppFileGenerator.release_app_sample(current_user.profile).to_stream.read,
              :filename => "vydacha_" + l(Time.now, :format => "%Y-%m-%d_%I-%M") + "_blank.xlsx",
              :type => "application/xlsx"
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
