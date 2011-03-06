class FundationAdmin < ActiveRecord::Base
  belongs_to :member
  belongs_to :fundation
  validates :fundation_id, :presence => true, :uniqueness => {:scope => :member_id}
end
