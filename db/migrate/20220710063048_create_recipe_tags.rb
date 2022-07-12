class CreateRecipeTags < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_tags do |t|
      t.references :recipe, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
    # 同じタグを保存できないようにする
    add_index :recipe_tags, [:recipe_id, :tag_id], unique: true
  end
end
