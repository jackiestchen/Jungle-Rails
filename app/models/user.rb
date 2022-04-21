class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6}

  def self.authenticate_with_credentials(email, password)
    email.strip!
    
    user = User.find_by(email: email.downcase)&.authenticate(password)
    if user  
      user
    else 
      nil
    end
  end

end


