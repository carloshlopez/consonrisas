class Provider < ActiveRecord::Base
  has_many :shows, :dependent => :destroy  
  has_and_belongs_to_many :events, :join_table => :events_providers
  belongs_to :member
  has_many :contact_informations, :dependent => :destroy
  has_and_belongs_to_many :facilitators, :join_table => :providers_facilitators
end
