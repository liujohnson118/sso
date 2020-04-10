require 'idp_settings_adapter'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :active_user_session?
  helper_method :saml_session?

  def active_user_session?
    @active_user_session ||= (current_user || saml_session?)
  end

  def saml_session?
    @saml_session_check ||= session[:nameid] && session[:saml_issuer]
  end

end
