Rails.application.routes.draw do
  get  "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  root "static_pages#home"
  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
  end
end
