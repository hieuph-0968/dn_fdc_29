Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"
  root "topics#index"
  get "sessions/new"
  get  "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  resources :password_resets,     only: [:new, :create, :edit, :update]
  scope "(:locale)", locale: /en|vi/ do
    resources :users
    resources :topics do
      resources :posts
    end
  end
end
