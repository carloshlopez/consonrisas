class EventFundation < ActiveRecord::Base
  belongs_to :event
  belongs_to :facilitator
  validates :event_id, :presence => true, :uniqueness => {:scope => :fundation_id}
end
