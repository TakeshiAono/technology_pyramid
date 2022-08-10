class AddColumnToPyramids < ActiveRecord::Migration[6.0]
  def change
    add_reference :pyramids, :work, null: false, foreign_key: true
  end
end
