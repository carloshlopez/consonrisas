class GlobalAlert < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::TextHelper

  after_create :send_mails, :add_to_daily_weekly, :share
  before_destroy :destroy_alert_dependencies

  def share

    obj = self.model.constantize.find(self.model_id)
    link = send("#{self.model.downcase}_url", obj)
    message = self.news + " " + self.name_link

    # facebook
    begin
      page = FbGraph::Page.new(Consonrisas::Application.config.fb.page_id)
      page.feed!(:access_token => Consonrisas::Application.config.fb.auth_token, :link => link, :message => message)
    rescue => e
      puts "Error posting global_alert to facebook: #{e.inspect}"
    end

    # twitter
#    begin
#      Twitter.update(truncate(message, :length => 92) + " " + link + " @consonrisas");
#    rescue => e
#      puts "Error posting global_alert to twitter: #{e.inspect}"
#    end

  end
  handle_asynchronously :share  

  def add_to_daily_weekly
    DailyAlert.create(:global_alert_id => self.id);
    WeeklyAlert.create(:global_alert_id => self.id);
  end

  def send_mails
    begin
    
#TODO find a better way to send email to all users
#      array_of_user_emails = Member.select(:email).where('emailNotifications = ?', true).map(&:email)

#      array_of_user_emails.each do |mail|
#        SendMsg.global_alert_msg(mail, self).deliver
#      end
      Member.instantly_mails.each do |member|
        SendMsg.global_alert_msg(member, self).deliver if member.emailNotifications? and member.emailInstantly?
      end
    rescue => e
      puts "Error sending mail #{e.message}"
    end
  end
  handle_asynchronously :send_mails
  
  private
  
  def destroy_alert_dependencies
    WeeklyAlert.destroy_all "global_alert_id = #{self.id}"
    DailyAlert.destroy_all "global_alert_id = #{self.id}"    
  end
end
