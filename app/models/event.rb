class Event < ActiveRecord::Base
  has_many :comments
  has_and_belongs_to_many :facilitators, :join_table => :events_facilitators
  has_and_belongs_to_many :fundations, :join_table => :events_fundations
  has_and_belongs_to_many :providers, :join_table => :events_providers  
  has_and_belongs_to_many :shows, :join_table => :events_shows  
end
