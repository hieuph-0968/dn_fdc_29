Rails.application.routes.draw do
  root "application#hello"
  scope "(:locale)", locale: /en|vi/ do
    resources :users
  end
end
