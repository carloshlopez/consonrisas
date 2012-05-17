class AddNotificacionOptionsToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :emailDaily, :boolean, :default=> true
    add_column :members, :emailWeekly, :boolean, :default=> false
    add_column :members, :emailInstantly, :boolean, :default=> false
  end

  def self.down
    remove_column :members, :emailDaily
    remove_column :members, :emailWeekly
    remove_column :members, :emailInstantly        
  end
end
