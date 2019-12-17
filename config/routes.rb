Rails.application.routes.draw do

  devise_for :users

  get 'welcome/index'
  root 'welcome#index'
  resources :products
  resources :profiles
  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end