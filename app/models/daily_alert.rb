class DailyAlert < ActiveRecord::Base
  belongs_to :global_alert
end
