class AddOptionsToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :choice1, :text
    add_column :questions, :choice2, :text
    add_column :questions, :choice3, :text
    add_column :questions, :choice4, :text
  end
end
