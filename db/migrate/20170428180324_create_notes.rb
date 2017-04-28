class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string :note_title, null: false
      t.text :note_detail
      t.boolean :favorite
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
