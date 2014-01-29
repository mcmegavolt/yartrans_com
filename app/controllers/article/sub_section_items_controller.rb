class Article::SubSectionItemsController < InheritedResources::Base

	load_and_authorize_resource
  skip_authorize_resource :only => :show

  def create
    create!(:notice => "Sub section item was created!")
  end

  def update
    update!(:notice => "Sub section item was updated!")
  end

  def destroy
    destroy!(:notice => "Sub section item was deleted!")
  end

end
