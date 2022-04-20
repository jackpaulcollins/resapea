class ChangeTagEnumColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :tags, :value, :compatible_with
  end
end
