class Video < ActiveRecord::Base
  belongs_to :event
  
  validates :url, :presence => true, :length => { :maximum => 250 }
end
