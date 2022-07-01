class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :content
      t.integer :importance
      t.datetime :day
      t.string :tag
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
