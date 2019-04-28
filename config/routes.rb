Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'static_pages#home'
  get 'static_pages/home'
  get '/privacy', to: 'static_pages#privacy'
  get '/about', to: 'static_pages#about'
  resources :users
  get 'twitter-disconnect', to: 'users#twitter-disconnect'
  resources :projects
end
