Rails.application.routes.draw do
  
  
  devise_for :customer,skip: [:passwords], controllers: {
  registrations: "customer/registrations",
  sessions: 'customer/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

root to: 'customer/homes#top'

  namespace :public do
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
  
  
  
  #   get 'customers/index'
  #   get 'customers/show'
  #   get 'customers/edit'
  # end
  # namespace :admin do
  #   get 'comments/show'
  # end
  # namespace :admin do
  #   get 'genres/index'
  #   get 'genres/edit'
  # end
  # namespace :admin do
  #   get 'homes/top'
  # end
  # namespace :customer do
  #   get 'customers/new'
  #   get 'customers/show'
  #   get 'customers/edit'
  #   get 'customers/unsubscribe'
  # end
  # namespace :customer do
  #   get 'comments/new'
  #   get 'comments/edit'
  # end
  # namespace :customer do
  #   get 'posts/new'
  #   get 'posts/index'
  #   get 'posts/show'
  #   get 'posts/edit'
  # end
  # namespace :customer do
  #   get 'homes/top'
  #   get 'homes/about'
  # end

  # devise_for :customers
  # devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end