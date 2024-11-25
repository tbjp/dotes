class CreateHosts < ActiveRecord::Migration[7.1]
  def change
    create_table :hosts do |t|
      t.string :first_name
      t.string :last_name
      t.string :voice
      t.string :nationality
      t.integer :age
      t.string :location
      t.string :family
      t.string :likes
      t.string :dislikes
      t.string :hobbies
      t.string :stories, array: true

      t.timestamps
    end
  end
end
