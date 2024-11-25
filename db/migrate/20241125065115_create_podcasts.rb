class CreatePodcasts < ActiveRecord::Migration[7.1]
  def change
    create_table :podcasts do |t|
      t.references :user_language, null: false, foreign_key: true
      t.references :host, null: false, foreign_key: true
      t.text :transcript
      t.string :summary
      t.string :ai_summary
      t.string :native_language
      t.string :level
      t.string :learning_style
      t.string :user_prompt
      t.string :title

      t.timestamps
    end
  end
end
