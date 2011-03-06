class AddMailToAdminFundations < ActiveRecord::Migration
  def self.up
    add_column :fundation_admins, :e_mail, :string
  end

  def self.down
    remove_column :fundation_admins, :e_mail
  end
end
