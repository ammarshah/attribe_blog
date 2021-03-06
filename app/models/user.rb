class User < ActiveRecord::Base
  attr_accessor :password

  EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
  before_save :encrypt_password
  after_save :clear_password

  has_many :articles
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
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
