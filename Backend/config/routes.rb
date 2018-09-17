Rails.application.routes.draw do

=begin  get "special", to: "welcome#index"
=begin resources :"users" only /except :[:create, :show]
  get 'welcome/index'
=end

  resources :users
  root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
