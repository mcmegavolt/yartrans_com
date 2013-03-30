class Cabinet::DashboardController < ApplicationController
  
  layout 'cabinet'

  before_filter :require_client_access

  def require_client_access
    authorize! :log, :cabinet
  end

  def admission_apps
  	@admission_apps ||= current_user.admission_apps
  end
  helper_method :admission_apps

  def release_apps
  	@release_apps ||= current_user.release_apps
  end
  helper_method :release_apps

  def news_items
    @news_items ||= NewsItem.last(5)
  end
  helper_method :news_items

end