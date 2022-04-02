class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :username
  validates_uniqueness_of :username
  has_many :recipes
  has_many :comments
  before_save { self.email = email.downcase }
  validates :password, length: { minimum: 6 }

  attr_accessor :remember_token

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine::cost
    BCrypt::Password::create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
   end
   
   def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
   end
   
   def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
   end
   
   private
   
   def generate_token
    SecureRandom.hex(10)
   end
end
