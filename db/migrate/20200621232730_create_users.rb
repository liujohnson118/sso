class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :encrypted_address
      t.string :encrypted_address_iv
      t.string :encrypted_email
      t.string :encrypted_email_iv
      t.string :encrypted_full_name
      t.string :encrypted_full_name_iv
      t.string :encrypted_phone_number
      t.string :encrypted_phone_number_iv
      t.timestamps null: false
    end
    add_index :users, :encrypted_address_iv, unique: true
    add_index :users, :encrypted_email_iv, unique: true
    add_index :users, :encrypted_full_name_iv, unique: true
    add_index :users, :encrypted_phone_number_iv, unique: true
  end
end
