class CreateProviderAdmins < ActiveRecord::Migration
  def self.up
    create_table :provider_admins do |t|
      t.integer :member_id
      t.integer :provider_id
      t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :provider_admins
  end
end
