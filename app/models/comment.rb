class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  accepts_nested_attributes_for :recipe, :user
end
