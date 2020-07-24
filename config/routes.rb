Rails.application.routes.draw do
  root 'posts#new'
  get 'posts/search'
  get 'posts/result'
  get 'static_pages/home'
  get 'static_pages/help'
end