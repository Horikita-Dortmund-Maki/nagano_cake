Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"
  get "home/about" =>"homes#about"
  post 'orders/confirm(/:id)', to: 'orders#confirm'
  get "/thanks" => "public/thanks#index"
  post 'order_details/confirm(/:id)', to: 'order_datails#confirm'

scope module: :public do
  resources :customers, only: [:show,:edit,:update,:create]
  resources :items, only: [:index,:show,:edit,:update]
  resources :cart_items, only: [:show, :destroy]
  resources :orders, only: [:show,:comfirm,:create,:index]
  resources :order_details, only: [:show,:comfirm,:create,:index]
  resources :addresses, only: [:index,:edit,:destroy,:create,:update]
end
  
  
  namespace :admin do
    resources :customers, only: [:index,:show,:edit,:update]
    resources :order_details, only: [:show]
    resources :orders, only: [:index,:edit,:update]
    resources :genres, only: [:index,:edit,:update,:create]
    resources :items, only: [:idnex, :show,:edit,:new,:create]
  end


end
