class AddCompanyInfoToFacilitator < ActiveRecord::Migration
  def self.up
    add_column :facilitators, :isCompany, :boolean, :default=>false    
    add_column :facilitators, :companyAddress, :string
    add_column :facilitators, :companyPhone, :string
    add_column :facilitators, :website, :string    
  end

  def self.down
    remove_column :facilitators, :companyAddress
    remove_column :facilitators, :companyPhone
    remove_column :facilitators, :isCompany
    remove_column :facilitators, :website
  end
end
