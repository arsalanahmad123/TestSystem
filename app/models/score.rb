class Score < ApplicationRecord
  belongs_to :paper
  belongs_to :user


  def calculate_percentage 
    percentage = (self.score.to_f / self.total_question_count.to_f) * 100
    percentage = percentage.to_i
    if percentage >= 90
       "Congratulations, you got #{percentage}%, you have passed the paper 😎"
    else
       "You got #{percentage}%, better luck next time 😔"
    end

  end

end
