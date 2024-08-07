class Paper < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
    validates :title, presence: true, length: { minimum: 3, maximum: 50 }
    validates :description, presence: true, length: { minimum: 10, maximum: 300 }
    validates :minutes, presence: true, numericality: { only_integer: true, greater_than: 0 }
    has_many :questions, dependent: :destroy
    has_many :scores,dependent: :destroy
    has_many :attempted_papers, dependent: :destroy    

end
