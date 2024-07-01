class AttemptedPaper < ApplicationRecord
  belongs_to :user
  belongs_to :paper
end
