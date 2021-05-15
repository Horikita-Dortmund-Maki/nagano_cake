Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"
  get "home/about" =>"homes#about"
  resources :customers, only: [:show,:edit,:update,:create]
  resources :items, only: [:index,:show,:edit,:update]
  resources :cart_items, only: [:show, :destroy]
  resources :order, only: [:show,:comfirm,:create,:index]
  post 'orders/confirm(/:id)', to: 'orders#confirm'
  get "/thanks" => "thanks#index"
  resources :order_detail, only: [:show,:comfirm,:create,:index]
  post 'order_details/confirm(/:id)', to: 'order_datails#confirm'
  resources :addresses, only: [:index,:edit,:destroy,:create,:update]
  
  namespace :admin do
    resources :customers, only: [:index,:show,:edit,:update]
    resources :order_details, only: [:show]
    resources :orders, only: [:index,:edit,:update]
    resources :genre, only: [:index,:edit,:update,:create]
    resources :items, only: [:show,:edit,:new,:create]
  end


end
