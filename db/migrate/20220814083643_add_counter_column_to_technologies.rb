class AddCounterColumnToTechnologies < ActiveRecord::Migration[6.0]
  def change
    add_column :technologies, :good_counter, :bigint
    add_column :technologies, :access_counter, :bigint
  end
end
