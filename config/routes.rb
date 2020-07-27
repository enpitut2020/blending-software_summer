Rails.application.routes.draw do
  root 'posts#new'
  get 'posts/search'
  get 'posts/result'
  get 'posts/details'
  get 'static_pages/home'
  get 'static_pages/help'
end