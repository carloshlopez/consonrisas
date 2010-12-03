class Role < ActiveRecord::Base
  has_one :member
end
