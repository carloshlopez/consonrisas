class AddMemberRelations < ActiveRecord::Migration
  def self.up
    add_column :providers, :member_id, :integer
    add_column :fundations, :member_id, :integer    
    add_column :facilitators, :member_id, :integer    
  end

  def self.down
    remove_column :providers, :member_id
    remove_column :fundations, :member_id    
    remove_column :facilitators, :member_id
  end
end
