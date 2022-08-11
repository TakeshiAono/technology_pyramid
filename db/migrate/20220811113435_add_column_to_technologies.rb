class AddColumnToTechnologies < ActiveRecord::Migration[6.0]
  def change
    add_column :technologies, :basic_flag, :boolean
  end
end
