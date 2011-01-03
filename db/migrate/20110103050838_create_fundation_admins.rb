class CreateFundationAdmins < ActiveRecord::Migration
  def self.up
    create_table :fundation_admins do |t|
      t.integer :member_id
      t.integer :fundation_id
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :fundation_admins
  end
end
