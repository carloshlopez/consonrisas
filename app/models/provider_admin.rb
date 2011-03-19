class ProviderAdmin < ActiveRecord::Base
  belongs_to :member
  belongs_to :provider
  validates :provider_id, :presence => true, :uniqueness => {:scope => :member_id}    
end
