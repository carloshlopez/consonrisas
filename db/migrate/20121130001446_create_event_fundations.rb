class CreateEventFundations < ActiveRecord::Migration
  def self.up
    create_table :event_fundations do |t|
      t.references :event
      t.references :fundation
      t.boolean :pending_invitation
      t.boolean :is_going

      t.timestamps
    end

    events = Event.find(:all)        

    events.each do |e|
      e.fundations.each do |f|
        e.event_fundations.create(:fundation => f, :pending_invitation => false, :is_going => true)
      end
    end
  end

  def self.down
    drop_table :event_fundations
  end
end
