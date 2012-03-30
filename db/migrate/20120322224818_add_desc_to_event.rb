class AddDescToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :desc, :text    
  end

  def self.down
    remove_column :events, :desc
  end
end
