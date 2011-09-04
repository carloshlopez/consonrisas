class AddTypeAndMemberToAlert < ActiveRecord::Migration
  def self.up
    #el alert_type es 1: invitacion automatica de eventos\
#    2 un mensaje que se le envió un miembro a otro
    add_column :alerts, :alert_type, :integer, :default=>1
    add_column :alerts, :member_from, :integer
  end

  def self.down
    remove_column :alerts, :alert_type
    remove_column :alerts, :member_from
  end
end
