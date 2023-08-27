class TraverseQuestionsMigration < ActiveRecord::Migration[7.0]
  def down 
    drop_column :questions, :correct_option, :text
  end 
end
