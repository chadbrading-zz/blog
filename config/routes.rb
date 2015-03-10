Rails.application.routes.draw do
  root 'posts#index'

  resources :posts, only: [:new, :edit, :create, :update, :destroy]
  resources :authors, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
