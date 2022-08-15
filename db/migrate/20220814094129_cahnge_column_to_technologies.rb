class CahngeColumnToTechnologies < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :hierarckies, :technologies, column: :lower_technology_id,primary_key: :id
  end
end
