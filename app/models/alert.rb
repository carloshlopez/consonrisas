class Alert < ActiveRecord::Base
  belongs_to :member
  validates :link, :presence => true, :uniqueness => {:scope => :member_id}  

  after_create :generate_mails
  
  def generate_mails
  end
end
