class User < ApplicationRecord
    has_secure_password 
    validates :email,presence: true,uniqueness: true
    validates :username,presence: true 
    has_many :responses,dependent: :destroy
    has_many :scores,dependent: :destroy
    validates :password,length: {minimum:6, allow_nil: true}
    has_many :attempted_papers,dependent: :destroy

    enum role: [:student, :admin]
    after_initialize :set_default_role, :if => :new_record?
    
    def set_default_role
        self.role ||= :student
    end

    scope :all_except, -> (user) { where.not(id: user) }

    def find_score(paper)
        scores.find_by(paper_id: paper.id).try(:score)
    end
    
end
