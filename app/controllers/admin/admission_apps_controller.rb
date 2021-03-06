class Admin::AdmissionAppsController < Admin::DashboardController

	inherit_resources

  require 'app_file_generator'

  def show
    respond_to do |format|
      format.xlsx {
        send_data AppFileGenerator.render_admission_xlsx_file(resource).to_stream.read.force_encoding("UTF-8"), filename: AppFileGenerator.admission_file_name(resource)
      }
    end
  end

  def update
    update!(:notice => "Admission app was updated!")
  end

  def destroy
    destroy!(:notice => "Admission app was deleted!")
  end

  def process_app
    if resource.process_app!
      flash[:success] = t(:'admin.admission_apps.flash.processing')
      redirect_to admin_admission_apps_path
    else
      flash[:error] = t(:'admin.admission_apps.flash.error')
      redirect_to admin_admission_apps_path
    end
  end

  def complete_app
    if resource.complete_app!
      flash[:success] = t(:'admin.admission_apps.flash.completed')
      redirect_to admin_admission_apps_path
    else
      flash[:error] = t(:'admin.admission_apps.flash.error')
      redirect_to admin_admission_apps_path
    end
  end

  def stop_app
    if resource.stop_app!
      flash[:success] = t(:'admin.admission_apps.flash.stoped')
      redirect_to admin_admission_apps_path
    else
      flash[:error] = t(:'admin.admission_apps.flash.error')
      redirect_to admin_admission_apps_path
    end
  end

  protected
  
    def collection
        @admission_apps ||= AdmissionApp.with_state(params[:state].present? ? params[:state] : :pending).page params[:page]
    end

end
