class AddFollowersTables < ActiveRecord::Migration
  def self.up
    create_table :fundations_facilitators, :id => false do |t|
      t.integer :fundation_id
      t.integer :facilitator_id
    end
    
    create_table :providers_facilitators, :id => false do |t|
      t.integer :provider_id
      t.integer :facilitator_id
    end    
  end

  def self.down
    drop_table :fundations_facilitators
    drop_table :providers_facilitators
  end
end
