Rails.application.routes.draw do
  root 'posts#index', as: :authenticated_root
  resources :posts do
    resource :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
