Rails.application.routes.draw do
  get 'static_pages/home'
  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
  end
end
