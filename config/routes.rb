Rails.application.routes.draw do
  resources :activities
  resources :posts
  get 'users/index'
  get 'users/show'

  get "Timeline", to: "posts#index"
  get "Members", to: "users#index"

  resources :posts do
  	resources :comments
  	member do
       post 'upvote'
    end
  end
  devise_for :users
  resources :users
  get 'home/index'

  root 'home#index'
end
