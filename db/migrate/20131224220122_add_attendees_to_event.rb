class AddAttendeesToEvent < ActiveRecord::Migration
  def change
    add_column :events, :attendees, :integer
  end
end
