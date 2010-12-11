class Event < ActiveRecord::Base
  has_many :comments
  has_and_belongs_to_many :facilitators, :join_table => :events_facilitators, :uniq => true
  has_and_belongs_to_many :fundations, :join_table => :events_fundations, :uniq => true
  has_and_belongs_to_many :providers, :join_table => :events_providers, :uniq => true  
  has_and_belongs_to_many :shows, :join_table => :events_shows, :uniq => true  
  
  has_attached_file :pic, :styles => {:profile => "150x150>", :thumb => "50x50#"},
                    :storage => :s3,
                    :s3_credentials => "#{::Rails.root.to_s}/config/s3.yml",
                    :path => "events/:attachment/:id/:style/:filename"

#  validates_attachment_presence :pic
  validates_attachment_size :pic, :less_than => 5.megabytes
  validates_attachment_content_type :pic, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg']  
end
