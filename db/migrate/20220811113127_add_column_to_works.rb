class AddColumnToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :active_flag, :boolean
  end
end
