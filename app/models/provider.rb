class Provider < ActiveRecord::Base
  has_many :shows, :dependent => :destroy  
  has_and_belongs_to_many :events, :join_table => :events_providers, :uniq => true
  has_many :contact_informations, :dependent => :destroy, :dependent => :destroy  
  has_and_belongs_to_many :facilitators, :join_table => :providers_facilitators
  
  has_many :provider_admins, :dependent =>:destroy
  has_many :members, :through => :provider_admins, :dependent => :destroy  
  
  has_attached_file :pic, :styles => {:profile => "150x150>", :thumb => "50x50#"},
                    :storage => :s3,
                    :s3_credentials => "#{::Rails.root.to_s}/config/s3.yml",
                    :path => "providers/:attachment/:id/:style/:filename"
  
  validates_attachment_size :pic, :less_than => 5.megabytes
  validates_attachment_content_type :pic, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/pjpeg', 'image/x-png']
  
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 250 }
  validates :city, :presence => true, :length => { :maximum => 100 }  
  
  def ask_admin member_id
    ProviderAdmin.create(:member_id =>member_id, :provider_id => self.id, :active=>false)
  end
  
  def ask_admin_by_mail mail
    ProviderAdmin.create(:e_mail =>mail, :provider_id => self.id, :active=>false)
    # TODO send mail with invitation if email not registered
  end
  
end
