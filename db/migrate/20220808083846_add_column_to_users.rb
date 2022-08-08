class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :industry, :string
    add_column :users, :occupation, :string
    add_column :users, :admin, :boolean, default: false
  end
end
