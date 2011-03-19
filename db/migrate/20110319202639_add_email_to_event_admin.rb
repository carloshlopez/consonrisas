class AddEmailToEventAdmin < ActiveRecord::Migration
  def self.up
    add_column :event_admins, :email, :string
  end

  def self.down
    remove_column :event_admins, :email
  end
end
