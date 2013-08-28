class User < ActiveRecord::Base

  before_save {|user| user.email = user.email.downcase}
  before_create :create_remember_token
  validates :name,  presence: true, length: { maximum: 100}
  has_secure_password

  VALID_EMAIL_FORMAT = /\A^[\w+.\-]+@[a-z\d.\-]+\.[a-z]+\Z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_FORMAT },
                   uniqueness: {case_sensitive: false}


  validates :password, length: {minimum: 6}

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
    

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
      
    end
end


