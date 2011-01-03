class Fundation < ActiveRecord::Base
  belongs_to :population
  has_and_belongs_to_many :events, :join_table => :events_fundations, :uniq => true
#  belongs_to :member
  has_many :contact_informations, :dependent => :destroy
  has_and_belongs_to_many :facilitators, :join_table => :fundations_facilitators  
  
  has_many :fundation_admins
  has_many :members, :through => :fundation_admins
  
  has_attached_file :pic, :styles => {:profile => "150x150>", :thumb => "50x50#"},
                    :storage => :s3,
                    :s3_credentials => "#{::Rails.root.to_s}/config/s3.yml",
                    :path => "fundations/:attachment/:id/:style/:filename"
  
  validates_attachment_size :pic, :less_than => 5.megabytes
  validates_attachment_content_type :pic, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg']  
  
  def add_admin member_id
    
  end
end
