class Admin::DashboardController < ApplicationController
  
  layout 'admin'

  before_filter :require_admin_access

  def require_admin_access
    authorize! :log, :admin_panel
  end

end