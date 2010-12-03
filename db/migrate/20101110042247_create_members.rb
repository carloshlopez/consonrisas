class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string :email
      t.references :role
      t.references :contact_information

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
