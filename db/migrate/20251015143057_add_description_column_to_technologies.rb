class AddDescriptionColumnToTechnologies < ActiveRecord::Migration[6.0]
  def change
    add_column :technologies, :description, :text
  end
end
