# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :state
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
