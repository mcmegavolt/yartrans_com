Yartrans::Application.routes.draw do

  mount Ckeditor::Engine => "/ckeditor"

  # namespace :article do
  #   resources :categories, :path => 'c'
  # end

  resources :categories, :controller => "article/categories", :path => 'c'
  resources :pages, :controller => "article/pages", :path => 'p'

  root :to => 'home#index'

end
