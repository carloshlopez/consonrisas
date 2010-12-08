class Facilitator < ActiveRecord::Base
  has_and_belongs_to_many :events, :join_table => :events_facilitators
  belongs_to :member
  has_one :population
  has_and_belongs_to_many :fundations, :join_table => :fundations_facilitators
  has_and_belongs_to_many :providers, :join_table => :providers_facilitators  
  
  def has_complete_info
    is_it = true
    is_it = false unless name
    is_it
  end
  
end
