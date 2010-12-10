class Facilitator < ActiveRecord::Base
  has_and_belongs_to_many :events, :join_table => :events_facilitators
  belongs_to :member
  has_one :population
  has_and_belongs_to_many :fundations, :join_table => :fundations_facilitators
  has_and_belongs_to_many :providers, :join_table => :providers_facilitators  
  
  has_attached_file :pic, :styles => {:profile => "150x150>", :thumb => "50x50#"},
                    :storage => :s3,
                    :s3_credentials => "#{::Rails.root.to_s}/config/s3.yml",
                    :path => "facilitators/:attachment/:id/:style/:filename"

#  validates_attachment_presence :pic
  validates_attachment_size :pic, :less_than => 5.megabytes
  validates_attachment_content_type :pic, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  
  def has_complete_info
    is_it = true
    is_it = false unless name
    is_it
  end
  
end
