class AddManyPopulationsToFundation < ActiveRecord::Migration

  def self.up
#    remove_column :fundations, :population_id
    create_table :fundation_populations, :id => false do |t|
      t.integer :population_id
      t.integer :fundation_id
    end
  end
  def self.down
    drop_table :fundation_populations
  end  

end
