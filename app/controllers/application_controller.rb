class ApplicationController < ActionController::Base

  protect_from_forgery


  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  def after_sign_in_path_for(resource)
    if current_user.role? :admin 
      admin_path
    elsif current_user.role? :director 
      admin_path
    elsif current_user.role? :manager
      admin_path
    elsif current_user.role? :client
      cabinet_path
    end
  end
  
  def root_article_categories
    @root_article_categories = Article::Category.roots
  end
  helper_method :root_article_categories

  def static_article_pages
    @static_article_pages = Article::Page.static
  end
  helper_method :static_article_pages


end
