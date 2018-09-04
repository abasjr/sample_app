Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

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

  # Stats and follow form
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,        only: [:create, :destroy]

  # root 'static_pages#home'
  # get 'static_pages/help'
  # get 'static_pages/about'
  # get 'static_pages/home'
  # get 'static_pages/contact'
end
