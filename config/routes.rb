Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  get 'static_pages/home'
  get '/privacy', to: 'static_pages#privacy'
  get '/about', to: 'static_pages#about'
  resources :users
  resources :projects
end
