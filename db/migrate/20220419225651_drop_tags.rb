# frozen_string_literal: true

class DropTags < ActiveRecord::Migration[7.0]
  def change
    drop_table :tags
  end
end
