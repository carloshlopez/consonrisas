class Need < ActiveRecord::Base
  belongs_to :event
  after_create :generate_alerts
  
  private
  
  def generate_alerts
    GlobalAlert.create(:news=>"Hay una necesidad para el evento: ", :model=>"Event", :model_id=>event.id, :name_link=>"#{event.name} (#{name})")
  end  
  
end
