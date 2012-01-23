class AddNameToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :name, :string
  end

  def self.down
    remove_column :members, :name
  end
end
