Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    collection do
      get 'search_by_tag'
    end
    resources :comments, only: [:create, :destroy]
  end

  resources :tags, only: [:index, :show]

  root 'posts#index'
end