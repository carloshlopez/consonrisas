class CreateEventFacilitators < ActiveRecord::Migration
  def self.up
    create_table :event_facilitators do |t|
      t.references :event
      t.references :facilitator
      t.boolean :pending_invitation
      t.boolean :is_going

      t.timestamps
    end

    events = Event.find(:all)        

    events.each do |e|
      e.facilitators.each do |f|
        e.event_facilitators.create(:facilitator => f, :pending_invitation => false, :is_going => true)
      end
    end
  end

  def self.down
    drop_table :event_facilitators
  end
end
