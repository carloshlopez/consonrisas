class GlobalAlert < ActiveRecord::Base
  after_create :send_mails, :add_to_daily_weekly

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
end
