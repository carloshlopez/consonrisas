class CreateGlobalAlerts < ActiveRecord::Migration
  def self.up
    create_table :global_alerts do |t|
      t.string :news
      t.string :model
      t.string :model_id
      t.string :name_link
      t.timestamps
    end
  end

  def self.down
    drop_table :global_alerts
  end
end
