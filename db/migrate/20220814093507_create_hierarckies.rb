class CreateHierarckies < ActiveRecord::Migration[6.0]
  def change
    create_table :hierarckies do |t|
      t.references :technology, null: false, foreign_key: true
      t.bigint :upper_technology
      t.bigint :access_counter
      t.bigint :good_counter

      t.timestamps
    end
  end
end
