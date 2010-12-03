class CreateFacilitators < ActiveRecord::Migration
  def self.up
    create_table :facilitators do |t|
      t.text :contribution
      t.integer :population_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :facilitators
  end
end
