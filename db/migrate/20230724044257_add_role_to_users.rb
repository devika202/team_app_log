class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :string
    add_column :users, :default, :string
    add_column :users, :member, :string
  end
end
