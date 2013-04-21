class Admin::NewsItemsController < Admin::DashboardController

	inherit_resources

	actions :all, :except => [ :show ]

  def create
    create!(:notice => "News item was created!")
    for user in Role.find_by_name("Client").users do
      NewsItemMailer.news_item_notification(resource, user.email).deliver
    end
  end

  def update
    update!(:notice => "News item was updated!")
  end

  def destroy
    destroy!(:notice => "News item was deleted!")
  end

end
