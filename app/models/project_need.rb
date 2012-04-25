class ProjectNeed < ActiveRecord::Base
  belongs_to :fundation  
  belongs_to :need_category
end
