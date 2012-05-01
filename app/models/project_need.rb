class ProjectNeed < ActiveRecord::Base
  belongs_to :fundation  
  belongs_to :need_category
  after_create :generate_alerts
  after_initialize :init
  
  def help member_id
    self.state = "Suplida"
    self.save!
    send_help_found member_id
  end
  
  private
  def send_help_found member_id
    begin
      fundation.fundation_admins.each do |admin|
        NeedsMailer.help_found(member_id, admin.id, fundation.id, self).deliver  
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
