# frozen_string_literal: true

class SetTotalPointsToZero < ActiveRecord::Migration[7.0]
  def change
    recipes = Recipe.where(total_points: nil)

    recipes.each do |r|
      r.update(total_points: 0)
    end
  end
end
