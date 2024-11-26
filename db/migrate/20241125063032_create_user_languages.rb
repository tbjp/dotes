class CreateUserLanguages < ActiveRecord::Migration[7.1]
  def change
    create_table :user_languages do |t|
      t.references :user, null: false, foreign_key: true
      t.string :language
      t.string :level
      t.string :suggested_topics, array: true, default: []

      t.timestamps
    end
  end
end
