class AddDefaultValueToTotalPoints < ActiveRecord::Migration[7.0]
  def change
    change_column  :recipes, :total_points, :integer, :default => 0
    change_column :comments, :total_points, :integer, :default => 0
  end
end
