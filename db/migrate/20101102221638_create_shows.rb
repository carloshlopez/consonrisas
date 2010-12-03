class CreateShows < ActiveRecord::Migration
  def self.up
    create_table :shows do |t|
      t.string :costs
      t.string :description
      t.string :infrastructure
      t.string :offering
      t.string :requirements
      t.references :provider

      t.timestamps
    end
  end

  def self.down
    drop_table :shows
  end
end
