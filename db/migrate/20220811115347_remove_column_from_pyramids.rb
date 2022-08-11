class RemoveColumnFromPyramids < ActiveRecord::Migration[6.0]
  def change
    remove_column :pyramids, :name, :string
  end
end
