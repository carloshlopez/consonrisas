class AddEmailToProviderAdmin < ActiveRecord::Migration
  def self.up
    add_column :provider_admins, :email, :string
  end

  def self.down
    remove_column :provider_admins, :email
  end
end
