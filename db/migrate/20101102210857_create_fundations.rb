class CreateFundations < ActiveRecord::Migration
  def self.up
    create_table :fundations do |t|
      t.string :address
      t.string :cellphone
      t.string :city
      t.string :country
      t.text :description
      t.string :phone
      t.string :website

      t.timestamps
    end
  end

  def self.down
    drop_table :fundations
  end
end
