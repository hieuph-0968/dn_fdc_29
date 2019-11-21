class CreateUserHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :user_histories do |t|
      t.string :description
      t.string :type
      t.integer :type_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
