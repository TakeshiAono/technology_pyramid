class RemoveUpperLowerTechnologyFromTechnologies < ActiveRecord::Migration[6.0]
  def change
    remove_column :technologies, :upper_technology, :integer
    remove_column :technologies, :lower_technology, :integer
  end
end
