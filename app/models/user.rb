class User < ApplicationRecord
  attr_encrypted :address, key: Base64.decode64(Settings.secret_keys.user.address)
  attr_encrypted :email, key: Base64.decode64(Settings.secret_keys.user.email)
  attr_encrypted :full_name, key: Base64.decode64(Settings.secret_keys.user.full_name)
  attr_encrypted :phone_number, key: Base64.decode64(Settings.secret_keys.user.phone_number)
end
