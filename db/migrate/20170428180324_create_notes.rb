class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string :note_title
      t.string :note_detail
      t.boolean :favorite
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
