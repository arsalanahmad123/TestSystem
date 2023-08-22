class User < ApplicationRecord
    has_secure_password 
    validates :email,presence: true,uniqueness: true
    validates :password,presence: true
    validates :username,presence: true 

    enum role: [:student, :admin]
    after_initialize :set_default_role, :if => :new_record?
    def set_default_role
        self.role ||= :student
    end
    
end
