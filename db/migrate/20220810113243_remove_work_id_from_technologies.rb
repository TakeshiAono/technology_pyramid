class RemoveWorkIdFromTechnologies < ActiveRecord::Migration[6.0]
  def change
    remove_reference :technologies, :work, null: false, foreign_key: true
  end
end
