class EventProvider < ActiveRecord::Base
  belongs_to :event
  belongs_to :provider
  validates :event_id, :presence => true, :uniqueness => {:scope => :provider_id}
end
