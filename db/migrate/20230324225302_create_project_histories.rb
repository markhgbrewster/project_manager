# frozen_string_literal: true

class CreateProjectHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :project_histories do |t|
      t.text :description
      t.references :user, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
