Rails.application.routes.draw do
  root 'pages#index'
  # config/routes.rb
# ...

  # Defines the root path route ("/")e
  # root "articles#index"
  resources :users, only: [:new, :create,:index]
  resources :sessions,only: [:new, :create]
  delete 'users/logout',to: "sessions#destroy",as: 'logout'
  resources :papers do
  resources :questions, only: [:new, :create, :destroy]
end

put "/verify_user/:id",to: "users#verify_user",as: "verify_user"
get "/startpaper/:id",to: "papers#paperstart",as: "startpaper"
post "/startpaper/:id",to: "papers#submitPaper",as: "submitpaper"
get "/result/:id",to: "papers#resultpage",as: "resultpage"
put "/allowpaper/:id",to: "papers#allowpaper",as: "allowpaper"
get "user/profile",to: "users#profile",as: "profile"


end