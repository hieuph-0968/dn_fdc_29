Rails.application.routes.draw do
  get  "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    resources :users
  end
end
