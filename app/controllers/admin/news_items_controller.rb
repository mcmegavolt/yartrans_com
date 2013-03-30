class Admin::NewsItemsController < Admin::DashboardController

	inherit_resources

	actions :all, :except => [ :show ]

  def create
    create!(:notice => "News item was created!")
  end

  def update
    update!(:notice => "News item was updated!")
  end

  def destroy
    destroy!(:notice => "News item was deleted!")
  end

end
