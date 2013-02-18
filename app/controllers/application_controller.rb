class ApplicationController < ActionController::Base
  protect_from_forgery


  def root_article_categories
    @root_article_categories = Article::Category.roots
  end
  helper_method :root_article_categories

  def static_article_pages
    @static_article_pages = Article::Page.static
  end
  helper_method :static_article_pages


end
