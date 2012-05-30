class AddIsOwnerToEventAdmins < ActiveRecord::Migration
  def self.up
    add_column :event_admins, :is_owner, :boolean, :default=> false
  end

  def self.down
    remove_column :event_admins, :is_owner
  end
end
