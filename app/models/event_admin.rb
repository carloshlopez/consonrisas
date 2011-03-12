class EventAdmin < ActiveRecord::Base
  belongs_to :member
  belongs_to :event
  validates :event_id, :presence => true, :uniqueness => {:scope => :member_id}  
end
