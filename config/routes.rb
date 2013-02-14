Yartrans::Application.routes.draw do

  namespace :article do
    resources :categories
  end

  root :to => 'home#index'

end
