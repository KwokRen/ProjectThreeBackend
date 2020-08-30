Rails.application.routes.draw do
  resources :videos do
    resources :users do
      resources :comments
    end
  end
  resource :users, only: [:create] do
    resources :comments
  end


  # User routes
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  get "/videos/:video_id/comments", to:"comments#videocomments"
  post "/users/unique", to: "users#is_unique"

  # Define some like routes
  get "/video/:video_id/likes", to: "likes#show"
  get "/likes/show/:video_id/user/:user_id", to: "likes#show_user_vote"
  put "/likes/:video_id/users/:user_id", to: "likes#update"
  post "/likes/video/:video_id/users/:user_id", to: "likes#create"
  delete "/video/:video_id/:user_id/likes/:is_liked", to: "likes#destroy"
end