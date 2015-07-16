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
  
  resources :conversations do
    resources :messages
  end
  
  devise_for :users
  resources :users
=begin
  authenticated :user do
    root 'users#index'
  end
 
  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end
=end


  get 'home/index'
  root 'home#index'
end
