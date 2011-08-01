class CreateAuthentications < ActiveRecord::Migration
  def self.up
    create_table :authentications do |t|
      t.integer :member_id
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end

  def self.down
    drop_table :authentications
  end
end
