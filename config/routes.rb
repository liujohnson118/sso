Rails.application.routes.draw do
  root 'users#index'

  resources :users, except: [:new]

end
