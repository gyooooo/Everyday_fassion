Rails.application.routes.draw do
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
     root 'posts#index'
    get "home/about"=>"homes#about", as: "about"
    get "ranking"=>"posts#ranking", as: "ranking"
    get 'favorites/index'
    resources :genres, only: :show
    resources :tags do
      get 'posts', to: 'posts#search'
    end
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
     collection do
       get 'search'
     end
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
    resources :relationships, only: [:create, :destroy]
  end
  
  namespace :admin do
    root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :destroy]
    resources :comments, only: [:show, :index, :edit, :destroy]
  end
end