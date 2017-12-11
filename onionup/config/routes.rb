Rails.application.routes.draw do
  
    namespace :api, defaults: {format: :json} do
      resources :sites
      match 'ping/:id', to: 'sites#show_ping', via: [:get]
      match 'ping', to: 'sites#index_ping', via: [:get]
      resource :session, only: [:create, :destroy]
      resources :users, only: [:create] 
    end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  # resources :sites, only: [:show, :index, :create, :destroy, :new]
end
