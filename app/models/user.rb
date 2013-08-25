class User < ActiveRecord::Base


  validates :name,  presence: true, length: { maximum: 100}


  VALID_EMAIL_FORMAT = /\A^[\w+.\-]+@[\w+.\-]+\.[a-z]+\Z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_FORMAT }
end
