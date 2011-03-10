class Event < ActiveRecord::Base
  has_many :comments
  has_and_belongs_to_many :facilitators, :join_table => :events_facilitators, :uniq => true
  has_and_belongs_to_many :fundations, :join_table => :events_fundations, :uniq => true
  has_and_belongs_to_many :providers, :join_table => :events_providers, :uniq => true  
  has_and_belongs_to_many :shows, :join_table => :events_shows, :uniq => true  
  
  has_attached_file :pic, :styles => {:profile => "150x150>", :thumb => "50x50#"},
                    :storage => :s3,
                    :s3_credentials => "#{::Rails.root.to_s}/config/s3.yml",
                    :path => "events/:attachment/:id/:style/:filename"

#  validates_attachment_presence :pic
  validates_attachment_size :pic, :less_than => 5.megabytes
  validates_attachment_content_type :pic, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/pjpeg', 'image/x-png']  
  

  #validate :at_least_one_fundation  
  
  after_create :generate_alerts
  
  def generate_alerts
    self.fundations.each do |fundation|
      Show.find_all_by_population_id(fundation.population.id).each do |show|
        #puts "UHU NOTICIA PARA PROVEEDOR!!!!! #{show.inspect}"
        Alert.create(:member_id=> show.provider.member.id, :news=> I18n.t('events.provider_alert'))
      end
      Facilitator.find(:all, :include => :populations, :conditions => {"facilitator_populations.population_id" => fundation.population.id}).each do |facilitator|
        #puts "UHU NOTICIA PARA ESTE FACILITADOR!!!!! #{facilitator.inspect}"
        Alert.create(:member_id=> facilitator.member.id, :news=> I18n.t('events.facilitator_alert'), :link=>self.id)
      end      
    end
  end
  
  private 
  
  def at_least_one_fundation
    errors.add_to_base I18n.t('events.one_fundation_error') if self.fundations.blank?
  end
  
end
