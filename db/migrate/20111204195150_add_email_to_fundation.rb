class AddEmailToFundation < ActiveRecord::Migration
  def self.up
    add_column :fundations, :email, :string
  end

  def self.down
    remove_column :fundations, :email
  end
end
