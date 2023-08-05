Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:new, :create]
      post 'like', to: 'likes#create', as: :like
      delete 'unlike', to: 'likes#destroy', as: :unlike
    end
  end

  root "users#index" # Set the root path to the users index action

  # Add more routes as needed
end
