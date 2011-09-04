class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.integer :news_type
      t.string :title
      t.date :date
      t.text :news
      t.string :pic_file_name
      t.string :pic_content_type
      t.integer :pic_file_size
      t.datetime :pic_updated_at
      t.boolean :actual
      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
