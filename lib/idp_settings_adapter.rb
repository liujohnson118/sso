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

  def self.get_idp_name(idp_entity_id)
    case idp_entity_id
    when Settings.identity_providers.onelogin.idp_entity_id
      return 'onelogin'
    when Settings.identity_providers.okta.idp_entity_id
      return 'okta'
    else
      return nil
    end
  end

  def self.get_idp_homepage(idp_entity_id)
    idp_name = self.get_idp_name(idp_entity_id)
    return eval("Settings.identity_providers.#{idp_name}.idp_homepage")
  end
end