class Question < ApplicationRecord
  belongs_to :paper
  validates :content, presence: true
  validates :correct_option, presence: true ,inclusion: { in: 1..4 }
end
