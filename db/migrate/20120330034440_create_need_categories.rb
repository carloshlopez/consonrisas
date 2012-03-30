class CreateNeedCategories < ActiveRecord::Migration
  def self.up
    create_table :need_categories do |t|
      t.string :name_es
      t.string :name_en      

      t.timestamps
    end
  end

  def self.down
    drop_table :need_categories
  end
end
