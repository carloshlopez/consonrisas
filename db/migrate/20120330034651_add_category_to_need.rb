class AddCategoryToNeed < ActiveRecord::Migration
  def self.up
    add_column :project_needs, :need_categories_id, :integer
  end

  def self.down
    remove_column :project_needs, :need_categories_id
  end
end
