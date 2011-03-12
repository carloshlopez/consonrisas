class CreateEventAdmins < ActiveRecord::Migration
  def self.up
    create_table :event_admins do |t|
      t.integer :member_id
      t.integer :event_id
      t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :event_admins
  end
end
