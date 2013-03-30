class Admin::SettingsController < Admin::DashboardController

  def index
    @settings = Setting.thing_scoped.all
  end

  def edit
    @setting = Setting.find(params[:id])
    @setting[:value] = YAML.load(@setting[:value])
  end

  def update
    
    @setting = Setting.find(params[:id])
    @setting.var = params[:setting][:var]
    @setting.value = params[:setting][:value]

    if @setting.save
      flash[:success] = t(:'admin.settings.messages.saved')
      redirect_to admin_settings_path
    else
      render "edit"
    end
  end

end