Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations', sessions: 'users/sessions'}
  resources :user_groups
  resources :invites
  resources :users
  root to: 'user_groups#index'

  devise_scope :user do
    match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  end

  get 'verify', to: 'users#verify', as: 'verify'
  post 'verify', to: 'users#verify'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
