class AddAllowedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :allowed, :boolean, default: false
  end
end
