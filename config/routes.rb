Rails.application.routes.draw do
  namespace :customer do
    get 'favorites/index'
  end
  devise_for :customer, controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions',
  　passwords: 'customer/passwords',
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  
  devise_scope :customer do
    post 'customer/guest_sign_in', to: 'customer/sessions#guest_sign_in'
  end

 root to: 'customer/homes#top'

  namespace :customer do
    get "home/about"=>"homes#about", as: "about"
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
     resource :favorites, only: [:create, :destroy]
     resources :comments, only: [:create, :destroy]
    end
    get 'customers/unsubscribe' => 'customers#unsubscribe' 
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:new, :show, :index, :edit, :update] do
      member do
        get :favorite
      end
    end
    resources :commments, only: [:new, :edit]
  end
  
  namespace :admin do
    root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :update]
    resource :comments, only: [:show]
  end
end