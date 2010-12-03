class CreateJoinTablesForEvents < ActiveRecord::Migration
  def self.up
      create_table :events_facilitators, :id => false do |t|
        t.integer :event_id
        t.integer :facilitator_id
      end
      
      create_table :events_providers, :id => false do |t|
        t.integer :event_id
        t.integer :provider_id
      end      
      
      create_table :events_fundations, :id => false do |t|
        t.integer :event_id
        t.integer :fundation_id
      end      
      
      create_table :events_shows, :id => false do |t|
        t.integer :event_id
        t.integer :show_id
      end      
  end

  def self.down
    drop_table :events_facilitators
    drop_table :events_providers
    drop_table :events_fundations
    drop_table :events_shows
  end
end
