require 'sidekiq/web'

Rails.application.routes.draw do
  resources :timesheets
  resources :tickets do
    collection do
      post :import
    end
  end
  resources :issues do
    member do 
      patch :link
    end
    collection do
      post :import
    end
  end
  resources :projects
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  devise_for :users
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
