desc "This task is called by the Heroku scheduler add-on"
task :send_daily_alerts => :environment do
  num = DailyAlert.count
  if num > 0
    puts "Number of Feeds to send today: #{num}"
    Member.daily_mails.each do |member|
      SendMsg.daily_alerts(member).deliver if member.emailNotifications? and member.emailDaily?
    end
    DailyAlert.delete_all
    puts "All daily alerts should have been sent. Total alerts now shold be 0: #{DailyAlert.count}"
  else
    puts "No DailyAlerts to process"
  end
end

task :send_weekly_alerts => :environment do
  if Time.now.friday?
    num = WeeklyAlert.count
    if num > 0
      puts "Number of Feeds to send at the end of the week : #{num}"
      Member.weekly_mails.each do |member|
        SendMsg.weekly_alerts(member).deliver if member.emailNotifications? and member.emailWeekly?
      end
      WeeklyAlert.delete_all
      puts "All weekly alerts should have been sent. Total alerts now shold be 0: #{WeeklyAlert.count}"
    else
      puts "No WeeklyAlerts to process"
    end
  else
    puts "Not friday yet, today is: #{Time.now.wday}"
  end
end

task :activate_email_notifications => :environment do 

  Member.update_all(:emailDaily => true)
  Member.update_all(:emailWeekly => false)
  Member.update_all(:emailInstantly => false)   

end
