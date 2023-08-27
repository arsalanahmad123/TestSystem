class AddCorrectOptionToQuestions < ActiveRecord::Migration[7.0]
  def change 
    change_column :questions, :correct_option, :integer , null: false
  end
end
