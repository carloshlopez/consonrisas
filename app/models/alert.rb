class Alert < ActiveRecord::Base
  belongs_to :member
  validates :news, :presence => true
end
