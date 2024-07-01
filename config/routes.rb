Rails.application.routes.draw do
  root 'pages#index'
  # config/routes.rb
# ...
  get "/usersdata",to: "users#database",as: "users_data"
  # config/routes.rb

  # Defines the root path route ("/")e
  # root "articles#index"
  resources :users, only: [:new, :create,:index,:destroy,:edit,:update]
  resources :sessions,only: [:new, :create]
  delete '/logout',to: "sessions#destroy",as: 'logout'
  resources :papers do
  resources :questions
end

put "/verify_user/:id",to: "users#verify_user",as: "verify_user"
get "/startpaper/:id",to: "papers#paperstart",as: "startpaper"
post "/startpaper/:id",to: "papers#submitPaper",as: "submitpaper"
get "/result/:id",to: "papers#resultpage",as: "resultpage"
put "/allowpaper/:id",to: "papers#allowpaper",as: "allowpaper"
get "user/profile",to: "users#profile",as: "profile"
delete "resetpapers/:id",to: "users#resetuserpaper",as: "resetpapers"


end