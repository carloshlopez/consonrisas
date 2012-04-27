class ProjectNeed < ActiveRecord::Base
  belongs_to :fundation  
  belongs_to :need_category
  after_create :generate_alerts
  
  private
  
  def generate_alerts
    GlobalAlert.create(:news=>"Hay una necesidad en el proyecto social: ", :model=>"Fundation",:model_id=>fundation.id, :name_link=>"#{fundation.name} (#{name})")
  end  
end
