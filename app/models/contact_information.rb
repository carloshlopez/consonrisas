class ContactInformation < ActiveRecord::Base
  belongs_to :member
  belongs_to :provider
  belongs_to :fundation  
end
