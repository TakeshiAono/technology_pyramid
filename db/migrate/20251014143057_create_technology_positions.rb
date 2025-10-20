class CreateTechnologyPositions < ActiveRecord::Migration[6.0]
  def change
    create_table :technology_positions do |t|
      t.references :top_technology, null: false, foreign_key: { to_table: :technologies }
      t.references :target_technology, null: false, foreign_key: { to_table: :technologies }

      t.integer :x_pos, null: false, default: 0
      t.integer :y_pos, null: false, default: 0
      t.index %i[top_technology_id target_technology_id], unique: true, name: "index_tech_positions_on_top_tech_id_and_target_tech_id"

      t.timestamps
    end
  end
end
