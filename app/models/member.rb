class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :facebook_id, :use_facebook_pic
  
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
  
  after_create :create_facilitator

  def create_facilitator
    @facilitator = Facilitator.create(:member_id => id)
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
  
end
