class User
  include Ripple::Document  
  class << self
    include CustomSearch
  end
  
  property :role_id, String
  property :email, String
  property :password_hash, String
  property :password_salt, String
  property :password_reset_token, String
  property :password_reset_sent_at, DateTime
  timestamps!

  attr_accessible :role_id, :email, :password, :password_confirmation, :password_reset_token, :password_reset_sent_at

  attr_accessor :password
  before_save :encrypt_password

  before_create :generate_token

  validates :password, :presence => {:message => "Password can't be blank" }, :confirmation => {:message => "Your password and confirmation password does not match"}, :length => { :within => 6..40, :message => "Password should be of atleast 6 characters" }#, on: :create

  validates :password, length: { in: 6..40, :message => "Password should be of atleast 6 characters"  }#, allow_blank:true

  validates :password_confirmation, :presence => {:message => "Confirm Password can't be blank" }, :confirmation => {:message => "Your password and confirmation password does not match"}#, on: :create

  validates :password_confirmation, length: { in: 6..40 , :message => "Password should be of atleast 6 characters" }#, on: :update, allow_blank:true

  validate :verify_unique_email
  
  validates :email,
            :presence => {:message => "Email can't be blank" },
            :length => { :maximum => 255 },
            :format => { :with => /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i, :message =>"Please enter a proper email address"}

  def send_password_reset
    self.update_attribute :password_reset_token, generate_token
    self.update_attribute :password_reset_sent_at, Time.zone.now
    UserMailer.password_reset(self).deliver
  end
  
  def generate_token
    token = SecureRandom.urlsafe_base64
    token =  SecureRandom.urlsafe_base64 while self.password_reset_token == token
    token
  end

  def self.exists?(params)
    users = User.search_by params
    !users.empty?
  end

  def self.authenticate(email, password)
    user = User.find User.search_by(email: email)[0]
    if(user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt))
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end  

  def verify_unique_email
    if !(User.search_by(email: email).empty?)
      if !(self.email==User.find(key).email rescue nil)
        errors.add :email, "This email has already been taken"
      end
    end
  end

end
