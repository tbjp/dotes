class AddStatusToPodcast < ActiveRecord::Migration[7.1]
  def change
    add_column :podcasts, :status, :string
  end
end
