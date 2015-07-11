Rails.application.routes.draw do
  get "Timeline", to: "posts#index"
  resources :posts
  devise_for :users
  get 'home/index'

  root 'home#index'
end
