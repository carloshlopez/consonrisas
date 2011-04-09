class Photo < ActiveRecord::Base
  belongs_to :event
  
  has_attached_file :photo, 
    :styles => {:big=> "640x480", :med=>"300x300", :profile => "150x150>", :thumb => "50x50#"},
    :convert_options => { :thumb => '-quality 20 -strip', :med => "-quality 30 -strip", :big => "-quality 40 -strip", :original => "-quality 30 -strip"},
    :storage => :s3,
    :s3_credentials => "#{::Rails.root.to_s}/config/s3.yml",
    :path => "events/photos/:attachment/:id/:style/:filename"
                    
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/pjpeg', 'image/x-png']  
                      
end
