class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :favorite, foreign_key: { to_table: :users }
      t.index %i[user_id favorite_id], unique: true
      t.timestamps
    end
  end
end
