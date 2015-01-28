class Need < ActiveRecord::Base
  belongs_to :event
  after_create :generate_alerts
  has_and_belongs_to_many :facilitators, :join_table => :need_facilitators, :uniq => true  
  validates :name, :presence => {:message => 'Debes ingresar un nombre a la necesidad'}
  
  def help member_id
    fac = Member.find(member_id).facilitator
    unless self.facilitators.map(&:id).include?(fac.id)
      self.completed = true
      self.facilitators << fac
      self.save!
      send_help_found member_id
    end
  end  
  
  private

  def send_help_found member_id
    begin
      event.event_admins.each do |admin|
        NeedsMailer.help_found_event(member_id, admin.member_id, event.id, self).deliver 
        Alert.create(:news=>"Un Facilitador quiere ayudar con una necesidad En tu Evento: #{event.name} ", :link=>Member.find(member_id).facilitator.id, :member_id=> admin.member.id, :alert_type=>2, :member_from=>member_id)
      end
    
      NeedsMailer.help_reminder_event(member_id, event.id, self).deliver
      
    rescue => e
      puts "Error sending mails on model need send_help_found: #{e.message}"
    end
  end
  handle_asynchronously :send_help_found
  
  
  def generate_alerts
    GlobalAlert.create(:news=>"Hay una necesidad para el evento: ", :model=>"Event", :model_id=>event.id, :name_link=>"#{event.name} (#{name})")
  end  
  
end
