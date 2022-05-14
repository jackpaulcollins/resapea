# frozen_string_literal: true

class AddCompatibilitiesToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :compatibilities, :text, array: true, default: []
  end
end
