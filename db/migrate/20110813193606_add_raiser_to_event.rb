class AddRaiserToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :isRaiser, :boolean, :default=>false
  end

  def self.down
    remove_column :events, :isRaiser
  end
end
