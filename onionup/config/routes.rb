Rails.application.routes.draw do
  
    namespace :api, defaults: {format: :json} do
      resources :sites
    end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  resources :sites, only: [:show, :index, :create, :destroy, :new]
end
