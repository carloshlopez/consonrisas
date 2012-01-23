class AddProcessingToPics < ActiveRecord::Migration
  def self.up
    add_column :providers, :pic_processing, :boolean
    add_column :fundations, :pic_processing, :boolean
    add_column :facilitators, :pic_processing, :boolean        
    add_column :events, :pic_processing, :boolean    
    add_column :photos, :photo_processing, :boolean    
  end
  
  def self.down
    remove_column :providers, :pic_processing
    remove_column :fundations, :pic_processing
    remove_column :facilitators, :pic_processing
    remove_column :events, :pic_processing
    remove_column :photos, :photo_processing                
  end
end
