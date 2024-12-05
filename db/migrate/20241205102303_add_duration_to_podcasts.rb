class AddDurationToPodcasts < ActiveRecord::Migration[7.1]
  def change
    add_column :podcasts, :duration, :integer
  end
end
