class CreateEdicts < ActiveRecord::Migration[5.0]
  def change
    create_table :edicts do |t|
      t.string :japanese, null: false
      t.string :japanese_yomi, null: false
      t.string :english, null: false, array: true
      t.string :english_summary, null: false

      t.index :english, using: :gin
      t.index :english_summary

      t.timestamps
    end
  end
end
