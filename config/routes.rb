Rails.application.routes.draw do
  resources :videos do
    resources :users do
      resources :comments
    end
  end
  resource :users, only: [:create] do
    resources :comments
  end



  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  get "/videos/:video_id/comments", to:"comments#videocomments"
  post "/users/unique", to: "users#is_unique"
  #get "/likes/:video_id/likes", to: "videos#get_likes"
  #put "/video/stats", to: "videos#changeVote"
  get "/video/:video_id/likes", to: "likes#show"
  put "/likes/:video_id/users/:user_id", to: "likes#update"
  post "/likes/video/:video_id/users/:user_id", to: "likes#create"
  delete "/video/:video_id/:user_id/likes/:is_liked", to: "likes#destroy"
end