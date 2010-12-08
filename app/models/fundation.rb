class Fundation < ActiveRecord::Base
  belongs_to :population
  has_and_belongs_to_many :events, :join_table => :events_fundations
  belongs_to :member
  has_many :contact_informations, :dependent => :destroy
  has_and_belongs_to_many :facilitators, :join_table => :fundations_facilitators  
end
