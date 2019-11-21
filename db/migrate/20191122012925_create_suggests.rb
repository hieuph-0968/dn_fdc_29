class CreateSuggests < ActiveRecord::Migration[6.0]
  def change
    create_table :suggests do |t|
      t.string :name
      t.string :description
      t.string :picture
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
