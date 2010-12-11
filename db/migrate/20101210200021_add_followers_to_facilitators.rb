class AddFollowersToFacilitators < ActiveRecord::Migration
  def self.up
    create_table :facilitators_facilitators, :id => false do |t|
      t.integer :facilitator_id
      t.integer :followed_id
    end    
  end

  def self.down
    drop_table :facilitators_facilitators
  end
end
