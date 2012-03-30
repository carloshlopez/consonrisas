class ProjectNeed < ActiveRecord::Base
  belongs_to :fundation  
  has_one :need_category
end
