class RemoveNameAndGenderColumnsFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :gender
  end
end
