class EventFundation < ActiveRecord::Base
  belongs_to :event
  belongs_to :fundation
  validates :event_id, :presence => true, :uniqueness => {:scope => :fundation_id}
  scope :going, where(:is_going => true,:pending_invitation => false)  
  scope :not_going, where(:is_going => false, :pending_invitation => false)  
  scope :invited, where(:pending_invitation => true)    
end
