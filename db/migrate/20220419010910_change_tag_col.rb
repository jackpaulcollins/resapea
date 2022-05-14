# frozen_string_literal: true

class ChangeTagCol < ActiveRecord::Migration[7.0]
  def change
    change_column :tags, :compatible_with, :string
  end
end
