class AddTotalPointsToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :total_points, :integer
    add_index :comments, :total_points
  end
end
