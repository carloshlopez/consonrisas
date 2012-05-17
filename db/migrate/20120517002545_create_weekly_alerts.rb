class CreateWeeklyAlerts < ActiveRecord::Migration
  def self.up
    create_table :weekly_alerts do |t|
      t.references :global_alert

      t.timestamps
    end
  end

  def self.down
    drop_table :weekly_alerts
  end
end
