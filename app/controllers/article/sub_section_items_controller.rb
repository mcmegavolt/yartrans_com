class Article::SubSectionItemsController < InheritedResources::Base

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
