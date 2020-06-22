Rails.application.routes.draw do
  root 'users#index'
  get 'welcome/bitcoin_prices'

  resources :users

end
