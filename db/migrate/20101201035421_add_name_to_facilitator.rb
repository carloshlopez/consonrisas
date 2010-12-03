class AddNameToFacilitator < ActiveRecord::Migration
  def self.up
    add_column :facilitators, :name, :string
  end

  def self.down
    remove_column :facilitators, :name
  end
end
