class RemoveTechnologyIdFromPyramids < ActiveRecord::Migration[6.0]
  def change
    remove_reference :pyramids, :technology, null: false, foreign_key: true
  end
end
