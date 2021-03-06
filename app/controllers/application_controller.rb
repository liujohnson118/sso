require 'idp_settings_adapter'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :saml_session?

  def saml_session?
    @saml_session_check ||= session[:saml_issuer]
  end

end
