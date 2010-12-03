class AddNameToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :name, :string
  end

  def self.down
    remove_column :shows, :name
  end
end
