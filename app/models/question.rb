class Question < ApplicationRecord
  belongs_to :paper
  validates :content, presence: true
  validates :correct_option, presence: true 
  has_many :responses, dependent: :destroy



  def size 
    self.count.to_i 
  end

end
