class CreateNeeds < ActiveRecord::Migration
  def self.up
    create_table :needs do |t|
      t.string :name
      t.boolean :completed

      t.timestamps
    end
  end

  def self.down
    drop_table :needs
  end
end
