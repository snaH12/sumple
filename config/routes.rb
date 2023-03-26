Rails.application.routes.draw do
  
  root 'homes#top'
  get "homes/about" => "homes#about", as: "about"
  
  namespace :admin do
    get 'homes/top'
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new,:create, :show, :edit, :update]
  end
  
  namespace :public do
    resources :orders, only: [:index, :show, :create, :new]
    post 'orders/confirm'
    get 'orders/complete'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
     resources :cart_items, only: [:index, :update, :destroy, :create]
    delete "cart_items/destroy_all", to: "cart_items#destroy_all", as: "destroy_all"
    resources :customers, only: [:show,:edit]
    get 'customers/unsubscribe'
    get 'customers/withdrawal'
    resources :items, only: [:index, :show]
  end
  
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
 
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
} 
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
