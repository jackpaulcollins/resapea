# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.references :recipe, null: false, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
