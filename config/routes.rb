Yartrans::Application.routes.draw do

  devise_for :users, :path => 'client', :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  mount Ckeditor::Engine => "/ckeditor"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

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
      resources :reports
      collection do
        match 'search' => 'users#search', :via => [:get, :post], :as => :search
        get 'page/:page', :action => :index
      end
      member do
        get :confirm
        get :owes_money
        get :suspend
        get :no_debt
      end
    end
    resources :admission_apps, :path => 'admission'
    resources :release_apps, :path => 'release'
    resources :mailbox_messages, :path => 'msg' do
      member do
        delete 'trash'
        post 'untrash'
      end
      collection do
        delete 'trash'
      end
    end
    resource :dashboard
    resources :activity_feeds
    resources :settings
    resources :news_items
  end

  namespace :cabinet do
  	
    resources :admission_apps, :path => 'admission' do
      collection do
        get :download_sample
      end
    end
  	
    resources :release_apps, :path => 'release' do
      collection do
        get :download_sample
      end
    end

    resources :reports

    resources :mailbox_messages, :path => 'msg' do
      member do
        delete 'trash'
        post 'untrash'
      end
      collection do
        delete 'trash'
      end
    end

  end


  match '/admin' => "admin/dashboard#index"
  match '/cabinet' => "cabinet/dashboard#index"

  root :to => 'home#index'


end
