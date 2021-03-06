Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  root 'posts#index', as: :authenticated_root
  resources :posts do
    resources :comments do
      resources :likes
      post '/destroy' => 'likes#destroy', as: :destroy
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/registration' => 'authors#new'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :authors
  resources :sessions, only: [:new, :create, :destroy]

  resources :authors do
    member do
      get :confirm_email
    end
  end

  get 'pass_reset/new'
  resources :pass_reset
end
