class AddPlacesToEverything < ActiveRecord::Migration
  def self.up
    add_column :events, :city, :string
    add_column :events, :place, :string
    add_column :facilitators, :city, :string
    add_column :providers, :city, :string
  end

  def self.down
    remove_column :events, :city
    remove_column :events, :place
    remove_column :facilitators, :city
    remove_column :providers, :city
  end
end
