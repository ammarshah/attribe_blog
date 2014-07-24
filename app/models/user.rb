class User < ActiveRecord::Base
  attr_accessor :password

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  before_save :encrypt_password
  after_save :clear_password

  has_many :articles
  
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates_confirmation_of :password
  validates_presence_of :password
  validates_length_of :password, :in => 6..20, :on => :create
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def clear_password
      self.password = nil
  end

  def self.authenticate(email, password)
      user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      else
        nil
      end
    end

end
