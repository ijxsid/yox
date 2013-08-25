class User < ActiveRecord::Base

  before_save {|user| user.email = user.email.downcase}
  validates :name,  presence: true, length: { maximum: 100}
  has_secure_password

  VALID_EMAIL_FORMAT = /\A^[\w+.\-]+@[a-z\d.\-]+\.[a-z]+\Z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_FORMAT },
                   uniqueness: {case_sensitive: false}


  validates :password, length: {minimum: 6}
end


