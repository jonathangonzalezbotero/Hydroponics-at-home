Rails.application.routes.draw do

  devise_for :users
  get 'profile/index'

  get 'welcome/index'
  root 'welcome#index'
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
