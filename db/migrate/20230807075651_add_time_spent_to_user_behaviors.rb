class AddTimeSpentToUserBehaviors < ActiveRecord::Migration[5.1]
  def change
    add_column :user_behaviors, :time_spent, :integer
  end
end
