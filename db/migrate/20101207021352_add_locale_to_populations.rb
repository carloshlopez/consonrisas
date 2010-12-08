class AddLocaleToPopulations < ActiveRecord::Migration
  def self.up
    rename_column :populations, :name, :name_es
    rename_column :populations, :description, :description_es    
    add_column :populations, :name_en, :string
    add_column :populations, :description_en, :string    
  end

  def self.down
    rename_column :populations, :name_es, :name
    rename_column :populations, :description_es, :description
    remove_column :populations, :name_en
    remove_column :populations, :description_en
  end
end
