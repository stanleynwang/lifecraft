class AddAuthToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :crypted_password,  :null => false, :default => ''
      t.string :password_salt,     :null => false, :default => ''
      t.string :persistence_token, :null => false, :default => ''

    end
  end
end
