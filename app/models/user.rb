class User < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :large => "350x350>", :cover => "760x280#", :medium => "200x200#", :thumb => "50x50>"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   attr_accessor :login

   def self.find_first_by_auth_conditions(warden_conditions)
  	conditions = warden_conditions.dup
  		if login = conditions.delete(:login)
    		where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  		else
    		if conditions[:username].nil?
      			where(conditions).first
    		else
      			where(username: conditions[:username]).first
    		end
  		end
	end

  after_create :create_default_conversation

  has_many :posts
  has_many :comments
  has_many :activities
  has_many :conversations, :foreign_key => :sender_id
  has_many :messages

  has_many :friendships
  has_many :friends, :through => :friendships

  acts_as_messageable

  def mailboxer_name
    self.name
  end

  def mailboxer_email(object)
    self.email
  end

  private
  # for demo purposes

  def create_default_conversation
    Conversation.create(sender_id: 1, recipient_id: self.id) unless self.id == 1
  end

end
