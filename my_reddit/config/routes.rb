Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  root to: 'subs#index'
  resources :subs
  resources :posts, except: [:index] do
    resources :comments, only: [:new]
    post :upvote
    post :downvote
  end
  resources :comments, only: [:create, :show, :destroy]

end
