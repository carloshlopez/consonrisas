class Provider < ActiveRecord::Base
  has_many :shows, :dependent => :destroy  
  has_and_belongs_to_many :events, :join_table => :events_providers
  belongs_to :member
end
