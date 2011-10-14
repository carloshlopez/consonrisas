class AddIsClosedToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :isClosed, :boolean, :default=>false    
  end

  def self.down
    remove_column :events, :isClosed
  end
end
