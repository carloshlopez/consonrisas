class AddNameAndPopulationToFundation < ActiveRecord::Migration
  def self.up
    add_column :fundations, :name, :string
    add_column :fundations, :population_id, :integer
  end

  def self.down
    remove_column :fundations, :population_id
    remove_column :fundations, :name
  end
end
