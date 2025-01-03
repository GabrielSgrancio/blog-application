Rails.application.routes.draw do
  get "posts/index"
  get "posts/show"
  get "posts/new"
  get "posts/create"
  get "posts/edit"
  get "posts/update"
  get "posts/destroy"
  devise_for :users

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  root "posts#index"
end
