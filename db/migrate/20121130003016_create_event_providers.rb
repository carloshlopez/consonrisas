class CreateEventProviders < ActiveRecord::Migration
  def self.up
    create_table :event_providers do |t|
      t.references :event
      t.references :provider
      t.boolean :pending_invitation
      t.boolean :is_going

      t.timestamps
    end

    events = Event.find(:all)        

    events.each do |e|
      e.providers.each do |p|
        e.event_providers.create(:provider => p, :pending_invitation => false, :is_going => true)
      end
    end
  end

  def self.down
    drop_table :event_providers
  end
end
