class User < ActiveRecord::Base


  validates :name,  presence: true, length: { maximum: 100}
  validates :email, presence: true
end