require 'idp_settings_adapter'

class SessionActivityController < ApplicationController

  def destroy
    redirect_address = new_user_session_path
    redirect_address = IdpSettingsAdapter.get_idp_homepage(session[:saml_issuer]) if session[:saml_issuer]
    sign_out current_user
    respond_to do |format|
      format.js { render partial: 'destroy', locals: {redirect_address: redirect_address} }
    end
  end
end
