class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :name
      t.boolan :public_flag
      t.reference :user_id

      t.timestamps
    end
  end
end
