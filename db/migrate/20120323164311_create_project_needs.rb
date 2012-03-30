class CreateProjectNeeds < ActiveRecord::Migration
  def self.up
    create_table :project_needs do |t|
      t.string :name
      t.string :recurrence
      t.string :category
      t.string :state
      t.integer :fundation_id
      t.timestamps
    end
  end

  def self.down
    drop_table :project_needs
  end
end
