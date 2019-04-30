Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'static_pages#home'
  get 'static_pages/home'
  get '/privacy', to: 'static_pages#privacy'
  get '/about', to: 'static_pages#about'
  match 'users/:id' => 'users#destroy', via: :delete, as: :admin_destroy_user
  match 'users/:id' => 'users#show', via: :show, as: :user
  resources :users
  get 'twitter_disconnect', to: 'users#twitter_disconnect', controller: 'users'
  resources :projects
end
