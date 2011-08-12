class AddEmailNotificationsToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :emailNotifications, :boolean, :default=>true
  end

  def self.down
    remove_column :members, :emailNotifications
  end
end
