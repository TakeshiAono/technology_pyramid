class AddColumnToPyramids < ActiveRecord::Migration[6.0]
  def change
    add_column :pyramids, :parent_technology_id, :bigint
    add_column :pyramids, :child_technology_id, :bigint
    add_foreign_key :pyramids, :technologies, column: :parent_technology_id
    add_foreign_key :pyramids, :technologies, column: :child_technology_id
  end
end
