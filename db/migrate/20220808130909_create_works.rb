class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :title
      t.boolean :public_flag
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
