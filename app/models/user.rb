require 'bcrypt'

class User < ApplicationRecord

  # associations
  has_many :requests, :dependent=>:destroy
  has_many :comments, :through=>:requests, :dependent=>:destroy


  # real password as virtual attribute
  attr_accessor :password

  validates :nickName, :presence => true

  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 6..20 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 6..20, :on => :create

  before_save :encryptPassword
  after_save :clearPassword

  def encryptPassword
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.passwordHash = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clearPassword
    self.password = nil
  end

  def storedPasswordHashMatchesPassword(password, salt)
    return self.passwordHash == BCrypt::Engine.hash_secret(password, salt)
  end

end
