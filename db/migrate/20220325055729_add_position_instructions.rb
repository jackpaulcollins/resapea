# frozen_string_literal: true

class AddPositionInstructions < ActiveRecord::Migration[5.2]
  def change
    add_column :instructions, :position, :integer
  end
end
