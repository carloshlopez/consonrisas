class DeleteContactInformationFromMember < ActiveRecord::Migration
  def self.up
    remove_column :members, :contact_information_id
  end

  def self.down
    add_column :members, :contact_information_id, :integer
  end
end
