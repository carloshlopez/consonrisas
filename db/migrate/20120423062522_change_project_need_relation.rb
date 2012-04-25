class ChangeProjectNeedRelation < ActiveRecord::Migration
  def self.up
    rename_column :project_needs, :need_categories_id, :need_category_id
  end

  def self.down
    rename_column :project_needs, :need_category_id, :need_categories_id
  end
end
