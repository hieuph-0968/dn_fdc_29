Rails.application.routes.draw do
  root "static_pages#home"
  get "sessions/new"
  get  "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
  end
end
