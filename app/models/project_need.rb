class ProjectNeed < ActiveRecord::Base
  belongs_to :fundation  
  belongs_to :need_category
  has_and_belongs_to_many :facilitators, :join_table => :project_need_facilitators, :uniq => true
  after_create :generate_alerts
  after_initialize :init
  
  def help member_id
    fac = Member.find(member_id).facilitator
    unless self.facilitators.map(&:id).include?(fac.id)
      self.state = "Suplida"   
      self.facilitators << fac
      self.save!
      send_help_found member_id
    end
  end
  
  private
  
  def send_help_found member_id
    begin
      fundation.fundation_admins.each do |admin|
        NeedsMailer.help_found(member_id, admin.member_id, fundation.id, self).deliver 
        Alert.create(:news=>"Un Facilitador quiere ayudar con una necesidad", :link=>Member.find(member_id).facilitator.id, :member_id=> admin.member.id, :alert_type=>2, :member_from=>member_id)
      end
      
      NeedsMailer.help_found_fundation(member_id, fundation.id, self, fundation.email).deliver if fundation.email
      NeedsMailer.help_reminder(member_id, fundation.id, self).deliver
      
    rescue => e
      puts "Error sending mails on project_need send_help_found: #{e.message}"
    end
  end
  handle_asynchronously :send_help_found
  
  def init
    self.state ||= "Pendiente"
  end
  
  def generate_alerts
    GlobalAlert.create(:news=>"Hay una necesidad en el proyecto social: ", :model=>"Fundation",:model_id=>fundation.id, :name_link=>"#{fundation.name} (#{name})")
  end  
end
