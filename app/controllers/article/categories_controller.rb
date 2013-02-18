class Article::CategoriesController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def create

      if article_category.save
        flash[:success] = 'Article category was successfully created.'
        redirect_to categories_path
      else
        render :action => "new"
      end

  end

  def edit
  end

  def update
    if article_category.update_attributes(params[:article_category])
      flash[:success] = 'Article category was successfully updated.'
      redirect_to category_path(article_category)
    else
      render :action => "edit"
    end
  end

  def destroy
    unless article_category.children.exists?
      article_category.destroy
    else
      flash[:error] = 'Can\'t delete non-empty article category'
    end
    redirect_to categories_path
  end

  def sort
    params[:'sorted-item'].each_with_index do |item, index|
      todo_item = Article::Category.find(item)
      todo_item.update_attribute :position, index
    end if params[:'sorted-item']
    render :nothing => true
  end

  def article_categories
    @article_categories ||= if params[:id]
                    else
                      Article::Category.roots
                    end
  end
  helper_method :article_categories

  def article_category
    @article_category ||= if params[:id]
      Article::Category.find_by_permalink(params[:id])
    else
      Article::Category.new(params[:article_category])
    end
  end
  helper_method :article_category

end
