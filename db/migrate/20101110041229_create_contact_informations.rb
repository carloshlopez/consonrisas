class CreateContactInformations < ActiveRecord::Migration
  def self.up
    create_table :contact_informations do |t|
      t.string :name
      t.string :email
      t.string :cellphone
      t.string :phone
      t.string :position

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_informations
  end
end
