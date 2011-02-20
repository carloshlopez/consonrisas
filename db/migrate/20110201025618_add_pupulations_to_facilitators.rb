class AddPupulationsToFacilitators < ActiveRecord::Migration
  def self.up
    remove_column :facilitators, :population_id
    create_table :facilitator_populations, :id => false do |t|
      t.integer :population_id
      t.integer :facilitator_id
    end
  end

  def self.down
    drop_table :facilitator_populations
  end
end
