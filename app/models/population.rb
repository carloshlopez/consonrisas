class Population < ActiveRecord::Base
  has_many :shows
  has_many :fundations
  has_and_belongs_to_many :facilitators, :join_table => :facilitator_populations, :uniq => true
end
