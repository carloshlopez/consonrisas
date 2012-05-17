class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
    :facebook_id, :use_facebook_pic, :emailNotifications, :name, :emailDaily, 
    :emailWeekly, :emailInstantly
  
  has_many :contact_informations, :dependent => :destroy 
  has_one :facilitator, :dependent => :destroy 
  has_many :comments, :dependent => :destroy 
  has_many :alerts, :dependent => :destroy 
  has_many :fundation_admins, :dependent => :destroy 
  has_many :fundations, :through => :fundation_admins
  has_many :event_admins, :dependent => :destroy 
  has_many :events, :through => :event_admins  
  has_many :provider_admins, :dependent => :destroy 
  has_many :providers, :through => :provider_admins  
  has_many :authentications, :dependent => :destroy 

  after_create :create_facilitator
  
  scope :instantly_mails, where(:emailNotifications => true, :emailInstantly => true)
  scope :daily_mails, where(:emailNotifications => true, :emailDaily => true)
  scope :weekly_mails, where(:emailNotifications => true, :emailWeekly => true)    

  def create_facilitator
    @facilitator = Facilitator.create(:member_id => id)
    @facilitator.update_attribute(:name,  name) if name
    send_welcome_msg
  end
    
  def is_fundation?
    is_it = false
    is_it = true if role_id == ApplicationHelper::ROLES[:fundation]
    is_it
  end
  
  def is_facilitator?
    is_it = false
    is_it = true if role_id == ApplicationHelper::ROLES[:facilitator]
    is_it
  end
  
  def is_provider?
    is_it = false
    is_it = true if role_id == ApplicationHelper::ROLES[:provider]
    is_it
  end
  
  def has_fundation_info?
    is_it = false
    unless fundation.nil?
      is_it = true if fundation.id and fundation.name
    end
    is_it
  end
  
  def has_facilitator_info?
    is_it = false
    unless facilitator.nil?
      is_it = true if facilitator.id
    end
    is_it
  end  
  
  def has_provider_info?
    is_it = false
    unless provider.nil?
      is_it = true if provider.id and provider.name
    end
    is_it
  end  
  
  def is_current(current_id)
    is_it = false
    is_it = true if id == current_id
    is_it
  end
  

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  def as_json(options={})
    options ||= {} # need this because to_json without options will pass nil to as_json
    options[:methods] ||= []; 
    options[:methods] << :id;
    options[:methods] << :sign_in_count;
    options[:methods] << :last_sign_in_at;
    options[:methods] << :admin;    
    super(options);
  end  
  
  def apply_omniauth(omniauth)
    case omniauth['provider']
    when 'facebook'
      self.apply_facebook(omniauth)
      self.update_attributes(:facebook_id => omniauth['uid'])
    when 'twitter'
      self.apply_twitter(omniauth)
    end
    authentications.build(hash_from_omniauth(omniauth))
  end

  def facebook
    @fb_user ||= FbGraph::User.me(self.authentications.find_by_provider('facebook').token)
  end

  def twitter
    unless @twitter_user
      provider = self.authentications.find_by_provider('twitter')
      @twitter_user = Twitter::Client.new(:oauth_token => provider.token, :oauth_token_secret => provider.secret) rescue nil
    end
    @twitter_user
  end

  def send_welcome_msg
    begin
      SendMsg.welcome_msg(self).deliver
    rescue => e
      puts "Error member send_welcome_msg: #{e.inspect}"
    end
  end
  handle_asynchronously :send_welcome_msg

  protected

  def apply_facebook(omniauth)
    
    if (extra = omniauth['extra']['user_hash'] rescue false)
      self.email = (extra['email'] rescue '')
    else
      self.email = omniauth['user_info']['email'] rescue '' if email.blank?
    end
  end

  def apply_twitter(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      # Example fetching extra data. Needs migration to User model:
      # self.firstname = (extra['name'] rescue '')
    end
  end

  def hash_from_omniauth(omniauth)
    {
      :provider => omniauth['provider'],
      :uid => omniauth['uid'],
      :token => (omniauth['credentials']['token'] rescue nil),
      :secret => (omniauth['credentials']['secret'] rescue nil)
    }
  end  
  

  
end
