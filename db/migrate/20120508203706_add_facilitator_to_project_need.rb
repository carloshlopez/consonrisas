class AddFacilitatorToProjectNeed < ActiveRecord::Migration
  def self.up
    create_table :project_need_facilitators, :id => false do |t|
      t.integer :project_need_id
      t.integer :facilitator_id
    end  
  end

  def self.down
    drop_table :project_need_facilitators
  end
end
