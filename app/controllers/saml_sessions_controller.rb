require 'idp_settings_adapter'

class SamlSessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, raise: false
  before_action :set_idp_entity_id

  def new
    if params[:idp_entity_id]
      request = OneLogin::RubySaml::Authrequest.new
      action = request.create(@saml_config)
      redirect_to action
    else
      redirect_to new_user_session_path
    end
  end

  def metadata
    meta = OneLogin::RubySaml::Metadata.new
    render :xml => meta.generate(@saml_config)
  end

  def create
    response_to_validate = OneLogin::RubySaml::Response.new(params[:SAMLResponse], settings: @saml_config)
    if response_to_validate.is_valid? && email = response_to_validate.nameid
      session[:saml_issuer] = @idp_entity_id
      if user = User.find_by_email(email)
        sign_in user
      else
        sign_in User.create(email: email, password: SecureRandom.base58(24))
      end
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  protected

  def relay_state
    @relay_state ||= if Devise.saml_relay_state.present?
                       Devise.saml_relay_state.call(request)
                     end
  end

  def generate_idp_logout_response(saml_config, logout_request_id)
    OneLogin::RubySaml::SloLogoutresponse.new.create(saml_config, logout_request_id, nil)
  end

  private

  def set_idp_entity_id
    if params[:idp_entity_id]
      @idp_entity_id = params[:idp_entity_id]
    elsif params[:SAMLRequest]
      @idp_entity_id = OneLogin::RubySaml::SloLogoutrequest.new(params[:SAMLRequest]).issuer
    elsif params[:SAMLResponse]
      response = OneLogin::RubySaml::Response.new(params[:SAMLResponse])
      begin
        @idp_entity_id = response.issuers.first
      rescue Exception
        if logout_response = OneLogin::RubySaml::Logoutresponse.new(params[:SAMLResponse])
          if logout_response.success?
            @idp_entity_id = logout_response.issuer
          end
        end
      end
    end
    @saml_config = IdpSettingsAdapter.saml_settings(@idp_entity_id)
  end
end
