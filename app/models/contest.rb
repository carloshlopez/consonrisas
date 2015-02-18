class Contest < ActiveRecord::Base
  attr_accessible :fundation_id, :fundation_name, :num_tickets, :story, :transport, :video, :email, :pic, :video_html
  belongs_to :fundation

  validates :num_tickets, :numericality => { :less_than_or_equal_to => 15, :greater_than => 0 }, :presence => true

  validates :email, :presence => true

  validates :fundation_id, :presence => true

  has_attached_file :pic, :styles => {:profile_big => "400x400>", :profile => "150x150>", :thumb => "50x50#"},
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :path => "contests/:attachment/:id/:style/:filename"
#  process_in_background :pic
#  validates_attachment_presence :pic
  validates_attachment_size :pic, :less_than => 10.megabytes
  validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/
  auto_html_for :video do
    html_escape
    image
    youtube(:width => 400, :height => 250, :autoplay => true)
    vimeo(:width => 400, :height => 250)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

end
