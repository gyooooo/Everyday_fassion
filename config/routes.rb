Rails.application.routes.draw do
  devise_for :customer, controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions',
  　passwords: 'customer/passwords',
  }

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

root to: 'customer/homes#top'

  namespace :customer do
    get "home/about"=>"homes#about", as: "about"
    resources :posts, only: [:new, :index, :show, :edit]
    resources :customers, only: [:new, :show, :edit]
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    resources :commments, only: [:new, :edit]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  
  namespace :admin do
    root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :update]
    resource :comments, only: [:show]
  end
end