class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, dependent: :delete_all
  has_many :instructions, dependent: :delete_all
  accepts_nested_attributes_for :recipe_ingredients, :instructions
end
