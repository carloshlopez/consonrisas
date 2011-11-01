class AddSecretToAuthentications < ActiveRecord::Migration
  def self.up
    add_column :authentications, :secret, :string
  end

  def self.down
    remove_column :authentications, :secret
  end
end
