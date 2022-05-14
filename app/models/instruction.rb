# frozen_string_literal: true

class Instruction < ApplicationRecord
  belongs_to :recipe
  validates_presence_of :content
  validates_presence_of :position
end
