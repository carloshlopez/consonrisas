class CreateDailyAlerts < ActiveRecord::Migration
  def self.up
    create_table :daily_alerts do |t|
      t.references :global_alert

      t.timestamps
    end
  end

  def self.down
    drop_table :daily_alerts
  end
end
