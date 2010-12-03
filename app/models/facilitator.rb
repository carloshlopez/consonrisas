class Facilitator < ActiveRecord::Base
  has_and_belongs_to_many :events, :join_table => :events_facilitators
  belongs_to :member
  has_one :population
end
