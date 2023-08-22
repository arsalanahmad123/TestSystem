class CreatePapers < ActiveRecord::Migration[7.0]
  def change
    create_table :papers do |t|
      t.string :title
      t.text :description
      t.integer :minutes
      t.timestamps
    end
  end
end
