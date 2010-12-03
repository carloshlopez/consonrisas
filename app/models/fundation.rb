class Fundation < ActiveRecord::Base
  belongs_to :population
  has_and_belongs_to_many :events, :join_table => :events_fundations
  belongs_to :member
end
