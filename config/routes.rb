Rails.application.routes.draw do
  resources :videos do
  end
  resource :users, only: [:create] do
    resources :comments
  end
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"

end