class ChangeCorrectOptionInQuestions < ActiveRecord::Migration[7.0]
  def change
    change_column :questions, :correct_option, :text, null: false
  end
end
