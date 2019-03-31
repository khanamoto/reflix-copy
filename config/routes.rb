Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :users

  # resources :mypage, only: %w(index)
  # namespace :mypage do
  #   resources :users
  # end
  resources :works, only: %w(index) do
    collection do
      get 'search'
    end
  end
  # resources :reviews

  # get '/terms', to: 'terms#index', as: 'terms'
  # get '/privacy', to: 'privacy#index', as: 'privacy'
  # get '/home', to: 'timelines#index', as: 'home'

  root 'works#index'
end
