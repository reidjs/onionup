Rails.application.routes.draw do
  
    namespace :api, defaults: {format: :json} do
      resources :sites
      resources :users, only: [:create, :new, :destroy]
    end

  devise_for :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  resources :sites, only: [:show, :index, :create, :destroy, :new]
  
end
