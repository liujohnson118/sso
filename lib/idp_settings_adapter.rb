class IdpSettingsAdapter
  def self.saml_settings(idp_entity_id)
    case idp_entity_id
    when Settings.identity_providers.onelogin.idp_entity_id
      return OneLogin::RubySaml::Settings.new(Settings.identity_providers.onelogin)
    when Settings.identity_providers.okta.idp_entity_id
      return OneLogin::RubySaml::Settings.new(Settings.identity_providers.okta)
    else
      return {}
    end
  end
end