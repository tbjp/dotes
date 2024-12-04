class CreateFlashcards < ActiveRecord::Migration[7.1]
  def change
    create_table :flashcards do |t|
      t.string :target_vocab
      t.string :native_definition
      t.boolean :correct, default: false
      t.references :podcast, null: false, foreign_key: true

      t.timestamps
    end
  end
end
