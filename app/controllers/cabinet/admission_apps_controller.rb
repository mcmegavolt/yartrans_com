class Cabinet::AdmissionAppsController < Cabinet::DashboardController
  
  def index
    authorize! :read, AdmissionApp
  end

  def show
    authorize! :read, AdmissionApp
  end

  def new
    authorize! :create, AdmissionApp
    admission_app.admission_items.build unless admission_app.admission_items
  end

  def create
    authorize! :create, AdmissionApp

    admission_app.user = current_user
    if admission_app.save
      flash[:success] = t(:'applications.admission.flash.created')
      redirect_to cabinet_admission_apps_path
    else
      flash[:error] = t(:'applications.admission.flash.not_created')
      render :action => "new"
    end
  end

  def edit
    authorize! :edit, AdmissionApp
  end

  def update
    
    authorize! :edit, AdmissionApp

    if admission_app.update_attributes(params[:admission_app])
      flash[:success] = 'admission_app was successfully updated.'
      redirect_to cabinet_admission_apps_path
    else
      render "edit"
    end
  end

  def destroy
    authorize! :destroy, AdmissionApp

    if admission_app.destroy
      flash[:success] = 'admission_app was successfully destroyed!'
      redirect_to cabinet_admission_apps_path
    end
  end

  def admission_apps
    @admission_apps ||= if params[:id]
      			    else
                    @admission_apps = current_user.admission_apps.page params[:page]
			          end
  end
  helper_method :admission_apps

  def admission_app
    @admission_app ||= if params[:id]
      AdmissionApp.find(params[:id])
    else
      AdmissionApp.new(params[:admission_app])
    end
  end
  helper_method :admission_app

end
