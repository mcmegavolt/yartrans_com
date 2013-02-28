Yartrans::Application.routes.draw do

  devise_for :users, :path => 'client', :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  mount Ckeditor::Engine => "/ckeditor"

  # namespace :article do
  #   resources :categories, :path => 'c'
  # end

  resources :categories, :controller => "article/categories", :path => 'c' do
    post 'sort', :on => :collection
  end
  resources :pages, :controller => "article/pages", :path => 'p' do
    post 'sort', :on => :collection
  end

  namespace :admin do
  	resources :users do
      collection do
        match 'search' => 'users#search', :via => [:get, :post], :as => :search
        get 'page/:page', :action => :index
      end
    end
    resource :dashboard
    resources :activity_feeds
  end

  namespace :cabinet do
  	resources :admission_applications, :path => 'admission'
  	resources :release_applications, :path => 'release'
  end


  match '/admin' => "admin/dashboard#index"
  match '/cabinet' => "cabinet/dashboard#index"

  root :to => 'home#index'


end
