class AddFacilitatorsToEventNeeds < ActiveRecord::Migration
  def self.up
    create_table :need_facilitators, :id => false do |t|
      t.integer :need_id
      t.integer :facilitator_id
    end    
  end

  def self.down
    drop_table :need_facilitators  
  end
end
