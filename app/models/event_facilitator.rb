class EventFacilitator < ActiveRecord::Base
  belongs_to :facilitator
  belongs_to :event
  validates :event_id, :presence => true, :uniqueness => {:scope => :facilitator_id}
end
