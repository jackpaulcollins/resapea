# frozen_string_literal: true

class GenerateFakeRecipes < ActiveRecord::Migration[7.0]
  def change
    u = User.last

    1000.times do
      Recipe.new({
                   user_id: 2,
                   name: 'Spaghetti',
                   genre: 'Breakfast',
                   cuisine: 'Italian',
                   compatibilities: ['Vegan'],
                   instructions_attributes: [{ position: 1, content: 'rice' }],
                   recipe_ingredients_attributes: [{ measurement_unit_quantity: '1', measurement_unit_type: 'tbspn',
                                                     ingredient_name: 'water' }]
                 }).save
    end
  end
end
