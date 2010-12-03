class AddPopulationToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :population_id, :integer
  end

  def self.down
    remove_column :shows, :population_id
  end
end	
