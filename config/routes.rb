Rails.application.routes.draw do
  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
    delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'    
  end
  devise_for :customers, skip: :all
    devise_scope :customer do
    get 'customers/sign_in' => 'customers/sessions#new', as: 'new_customer_session'
    post 'customers/sign_in' => 'customers/sessions#create', as: 'customer_session'
    delete 'customers/sign_out' => 'customers/sessions#destroy', as: 'destroy_customer_session'
    get 'customers/sign_up' => 'customers/registrations#new', as: 'new_customer_registration'
    post 'customers' => 'customers/registrations#create', as: 'customer_registration'
    get 'customers/password/new' => 'customers/passwords#new', as: 'new_customer_password'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"
  get "home/about" =>"homes#about"
  
  get "/thanks" => "public/thanks#index"
  post 'order_details/confirm(/:id)', to: 'order_datails#confirm'
  
  post '/add_item' => 'carts#add_item'
  post '/update_item' => 'carts#update_item'
  delete '/delete_item' => 'carts#delete_item'


  scope module: :public do
    resources :customers, only: [:show,:edit,:update,:create]
    get "customers/:id/unsubscribe" => "customers#unsubscribe" 
    put "/customers/:id/withdraw" => "customers#withdraw", as: "customers_withdraw"
    post 'orders/new' => 'orders#create'
    get "orders/confirm" => "orders#confirm"
    post "orders/confirm" => "orders#confirm"
    resources :items, only: [:index,:show,:edit,:update]
    resources :cart_items, only: [:show, :destroy]
    resources :orders, only: [:show,:confirm,:create,:index,:new]
    resources :order_details, only: [:show,:comfirm,:create,:index]
    resources :send_addresses, only: [:index,:edit,:destroy,:create,:update]
  end
  namespace :admin do
    resources :customers, only: [:index,:show,:edit,:update]
    resources :order_details, only: [:show]
    resources :orders, only: [:index,:edit,:update]
    resources :genre, only: [:index,:edit,:update,:create]
    resources :items, only: [:show,:edit,:new,:create]
  end


end
