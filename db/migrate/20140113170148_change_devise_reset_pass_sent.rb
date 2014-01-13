class ChangeDeviseResetPassSent < ActiveRecord::Migration
  def up
    change_column :members, :reset_password_sent_at, :time
  end

  def down
    change_column :members, :reset_password_sent_at, :datetime
  end
end
