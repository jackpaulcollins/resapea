# frozen_string_literal: true

class AddPhotoStringToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :photo_url, :string
  end
end
