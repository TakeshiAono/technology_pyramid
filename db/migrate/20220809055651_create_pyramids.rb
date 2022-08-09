class CreatePyramids < ActiveRecord::Migration[6.0]
  def change
    create_table :pyramids do |t|
      t.string :name
      t.boolean :public_flag
      t.references :technology, null: false, foreign_key: true

      t.timestamps
    end
  end
end
