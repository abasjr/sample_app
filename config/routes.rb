Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get  '/users/:id' => 'users#show'  #penggunaan to: sama => sama aja
  get  '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  resources :users

  # root 'static_pages#home'
  # get 'static_pages/help'
  # get 'static_pages/about'
  # get 'static_pages/home'
  # get 'static_pages/contact'
end
