Rails.application.routes.draw do
root to: 'users#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations', sessions: 'users/sessions'}
  resources :users

  get 'verify', to: 'users#verify', as: 'verify'
  post 'verify', to: 'users#verify'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
