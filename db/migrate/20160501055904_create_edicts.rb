class CreateEdicts < ActiveRecord::Migration[5.0]
  def change
    create_table :edicts do |t|
      t.string :japanese, null: false
      t.string :japanese_yomi, null: false
      t.string :english, null: false, array: true
      t.index :english, using: :gin

      t.timestamps
    end
  end
end
