class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.string :cooking_name
      t.string :material
      t.text :making
      t.string :make_time

      t.timestamps
    end
  end
end
