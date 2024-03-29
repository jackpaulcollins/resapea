# frozen_string_literal: true

class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :type
      t.references :user, foreign_key: true
      t.references :voteable, polymorphic: true
      t.timestamps
    end
  end
end
