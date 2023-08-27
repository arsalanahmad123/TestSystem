class Score < ApplicationRecord
  belongs_to :paper
  belongs_to :user


  def calculate_percentage 
    (self.score.to_f / self.total_question_count.to_f) * 100
  end

end
