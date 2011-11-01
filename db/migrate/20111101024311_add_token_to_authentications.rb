class AddTokenToAuthentications < ActiveRecord::Migration
  def self.up
    add_column :authentications, :token, :string
  end

  def self.down
    remove_column :authentications, :token
  end
end
