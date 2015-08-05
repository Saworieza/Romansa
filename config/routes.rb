Rails.application.routes.draw do
  resources :friendships
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

  # mailbox folder routes
  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  # conversations
  resources :convos do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end


  get 'home/index'
  root 'home#index'
end
