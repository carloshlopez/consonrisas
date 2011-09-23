class AddDescriptionToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :description, :text
  end

  def self.down
    remove_column :providers, :description
  end
end
