class AddPicToContest < ActiveRecord::Migration
  def self.up
    add_column :contests, :pic_file_name, :string
    add_column :contests, :pic_content_type, :string
    add_column :contests, :pic_file_size, :integer
    add_column :contests, :pic_updated_at, :datetime
  end

  def self.down
    remove_column :contests, :pic_file_name
    remove_column :contests, :pic_content_type
    remove_column :contests, :pic_file_size
    remove_column :contests, :pic_updated_at
  end
end
