class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true

  validates :password, :presence => true,
  :confirmation => true,
  :length => {:within => 6..40},
  :on => :create

end
