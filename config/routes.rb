Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

 # get '/posts/:post_id/comments/:id/edit' as: 'edit_post_comments'

  root 'posts#index', as: :authenticated_root
  resources :posts do
    resource :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/registration' => 'authors#new'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :authors
  resources :sessions, only: [:new, :create, :destroy]
end
