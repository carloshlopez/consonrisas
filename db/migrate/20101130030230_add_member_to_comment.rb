class AddMemberToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :member_id, :integer
  end

  def self.down
    remove_column :comments, :member_id
  end
end
