class Population < ActiveRecord::Base
  has_many :shows
  has_many :fundations
  belongs_to :facilitator
end
