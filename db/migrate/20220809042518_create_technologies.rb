class CreateTechnologies < ActiveRecord::Migration[6.0]
  def change
    create_table :technologies do |t|
      t.string :name
      t.boolean :public_flag
      t.integer :upper_technology
      t.integer :lower_technology
      t.references :work, null: false, foreign_key: true

      t.timestamps
    end
    add_foreign_key :technologies, :technologies, column: :upper_technology
    add_foreign_key :technologies, :technologies, column: :lower_technology
  end
end
