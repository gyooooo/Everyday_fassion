Rails.application.routes.draw do  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :admin do
    get 'comments/show'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :customer do
    get 'customers/new'
    get 'customers/show'
    get 'customers/edit'
    get 'customers/unsubscribe'
  end
  namespace :customer do
    get 'comments/new'
    get 'comments/edit'
  end
  namespace :customer do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  namespace :customer do
    get 'homes/top'
    get 'homes/about'
  end

  devise_for :customers
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
