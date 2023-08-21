class AddUrlToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :url, :string
  end
end
