class FundationAdmin < ActiveRecord::Base
  belongs_to :member
  belongs_to :fundation
end
