Rails.application.routes.draw do
  resources :videos do
    # we are nesting this resource inside videos only for the /videos/:video_id/comments route
    resources :comments
  end
  resource :users, only: [:create] do
    resources :comments
  end
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"

end