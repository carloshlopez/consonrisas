class AddFacebookIdToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :facebook_id, :string
  end

  def self.down
    remove_column :members, :facebook_id
  end
end
