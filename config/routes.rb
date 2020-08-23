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
end