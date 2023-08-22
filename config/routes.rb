Rails.application.routes.draw do
  root 'pages#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:new, :create]
  resources :sessions,only: [:new, :create]
  delete 'users/logout',to: "sessions#destroy",as: 'logout'
  resources :papers do
  resources :questions, only: [:new, :create, :destroy]
  end


end