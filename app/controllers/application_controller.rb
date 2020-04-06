class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :invalidate_user_session

  def invalidate_user_session
    if saml_issuer = session[:saml_issuer]
      settings = IdpSettingsAdapter.saml_settings(saml_issuer)
      request = OneLogin::RubySaml::Logoutrequest.new
      action = request.create(settings)
      redirect_to action, alert: I18n.t('session.not_logged_in')
    else
      #sign_out current_user
      redirect_to new_user_session_path, alert: I18n.t('session.not_logged_in')
    end
  end

end
