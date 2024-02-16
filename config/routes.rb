Rails.application.routes.draw do
  post 'auth/login', to: 'authentications#authenticate'
  post 'signup', to: 'users#create'

  resources :users, except: [:new, :edit]
end
