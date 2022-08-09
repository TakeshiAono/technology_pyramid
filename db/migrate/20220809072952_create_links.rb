class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :title
      t.string :url
      t.integer :good_counter
      t.references :technology, null: false, foreign_key: true

      t.timestamps
    end
  end
end
