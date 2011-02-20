class AddFacebookPicture < ActiveRecord::Migration
  def self.up
    add_column :members, :use_facebook_pic, :boolean, :default => false
  end

  def self.down
    remove_column :members, :use_facebook_pic
  end
end
