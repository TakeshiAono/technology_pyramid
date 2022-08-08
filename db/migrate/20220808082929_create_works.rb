class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :name
      t.boolean :public_flag
      t.references :user_id

      t.timestamps
    end
  end
end
