Rails.application.routes.draw do
  root 'posts#index'
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :posts, only: [:index, :new, :edit, :create, :update, :destroy, :show]
  resources :authors, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
