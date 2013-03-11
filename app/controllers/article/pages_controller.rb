class Article::PagesController < ApplicationController

  def index
  end

  def show
  end

  def new
    authorize! :create, article_page
  end

  def create
      if article_page.save
        flash[:success] = 'Article page was successfully created.'
        redirect_to pages_path
      else
        render :action => "new"
      end
      authorize! :create, article_page
  end

  def edit
    authorize! :edit, article_page
  end

  def update
    authorize! :edit, article_page
    if article_page.update_attributes(params[:article_page])
      flash[:success] = 'Article page was successfully updated.'
      redirect_to page_path(article_page)
    else
      render :action => "edit"
    end
  end

  def destroy
    authorize! :destroy, article_page
    if article_page.destroy
      flash[:error] = 'Page destroyed!'
      redirect_to category_path(article_page.category)
    end
  end

  def sort
    params[:'sorted-item'].each_with_index do |item, index|
      todo_item = Article::Page.find(item)
      todo_item.update_attribute :position, index
    end if params[:'sorted-item']
    render :nothing => true
  end

  def article_pages
    @article_pages ||= if params[:id]
                    else
                      Article::Page.all
                    end
  end
  helper_method :article_pages

  def article_page
    @article_page ||= if params[:id]
      Article::Page.find_by_permalink(params[:id])
    else
      Article::Page.new(params[:article_page])
    end
  end
  helper_method :article_page

end
