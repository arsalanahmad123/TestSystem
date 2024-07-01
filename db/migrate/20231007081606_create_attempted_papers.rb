class CreateAttemptedPapers < ActiveRecord::Migration[7.0]
  def change
    create_table :attempted_papers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :paper, null: false, foreign_key: true

      t.timestamps
    end
  end
end
