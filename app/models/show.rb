class Show < ActiveRecord::Base
  belongs_to :provider
  belongs_to :population
  has_and_belongs_to_many :events, :join_table => :events_shows
end
