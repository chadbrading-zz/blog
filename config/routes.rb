Rails.application.routes.draw do
  root 'posts#index'
  resource 'posts', only: [:edit, :update]
  resource 'authors', only: [:new, :create, :show]
  resource 'sessions', only: [:new, :create, :destroy]
end
