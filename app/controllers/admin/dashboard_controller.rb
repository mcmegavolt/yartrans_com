class Admin::DashboardController < ApplicationController
  
  layout 'admin'

  before_filter :require_admin_access

  def activity_feeds
  	@activity_feeds ||= ActivityFeed.all
  end
  helper_method :activity_feeds

  def require_admin_access
    authorize! :log, :admin_panel
  end

  def admission_apps
  	@admission_apps ||= current_user.admission_apps
  end
  helper_method :admission_apps

  def news_items
    @news_items ||= NewsItem.all
  end
  helper_method :news_items

  def admission_apps_count
    @count = AdmissionApp.all.count
  end
  helper_method :admission_apps_count

  def release_apps_count
    @count = ReleaseApp.all.count
  end
  helper_method :release_apps_count
  

end