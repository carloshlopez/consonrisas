class Population < ActiveRecord::Base
  has_many :shows
  has_and_belongs_to_many :fundations, :join_table => :fundation_populations, :uniq => true
  has_and_belongs_to_many :facilitators, :join_table => :facilitator_populations, :uniq => true
end
