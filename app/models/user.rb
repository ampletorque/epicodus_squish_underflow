class User < ActiveRecord::Base

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  attr_accessor :password
  validates_confirmation_of :password
  before_save :encrypt_password

  def set_default_role
    self.role ||= :user
  end

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def self.authenticate(email, password)
    user = User.where(email: email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

end
