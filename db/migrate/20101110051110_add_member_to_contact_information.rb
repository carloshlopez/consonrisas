class AddMemberToContactInformation < ActiveRecord::Migration
  def self.up
    add_column :contact_informations, :member_id, :integer
  end

  def self.down
    remove_column :contact_informations, :member_id
  end
end
