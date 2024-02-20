Rails.application.routes.draw do
  post 'auth/login', to: 'authentications#authenticate'

  resources :foods, except: [:new, :edit]
  resources :users, except: [:new, :edit]
end
