class AddContactInformationsToFundationsAndProviders < ActiveRecord::Migration
  def self.up
    add_column :contact_informations, :fundation_id, :integer
    add_column :contact_informations, :provider_id, :integer    
  end

  def self.down
    remove_column :contact_informations, :fundation_id
    remove_column :contact_informations, :provider_id    
  end
end
