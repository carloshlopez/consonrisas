class AddNeedsToEvent < ActiveRecord::Migration
  def self.up
    add_column :needs, :event_id, :integer
  end

  def self.down
    remove_column :needs, :event_id
  end
end
