Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users, skip: [:registrations, :saml_authenticatable]
  devise_scope :user do
    # SSO Routes
    get 'users/saml/sign_in' => 'saml_sessions#new', as: :new_saml_user_session
    post 'users/saml/auth' => 'saml_sessions#create', as: :user_sso_session
    match 'users/saml/sign_out' => 'saml_sessions#destroy', as: :destroy_user_sso_session, via: [:get, :post]
    get 'users/saml/metadata' => 'saml_sessions#metadata', as: :metadata_user_sso_session
  end

  get 'session_activity/destroy'
end
