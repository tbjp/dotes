class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :selected_user_language, foreign_key: { to_table: :user_languages }
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :native_language, :string
    add_column :users, :learning_style, :string
    add_column :users, :interests, :string
    add_column :users, :suggested_topics, :string, array: true
  end
end
