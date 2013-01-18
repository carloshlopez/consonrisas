class AddSeenToAlert < ActiveRecord::Migration
  def self.up
    add_column :alerts, :seen, :boolean, :default => false
  end

  def self.down
    remove_column :alerts, :seen
  end
end
