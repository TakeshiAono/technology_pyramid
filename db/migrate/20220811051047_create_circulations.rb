class CreateCirculations < ActiveRecord::Migration[6.0]
  def change
    create_table :circulations do |t|
      t.references :pyramid, null: false, foreign_key: true
      t.references :technology, null: false, foreign_key: true

      t.timestamps
    end
  end
end
