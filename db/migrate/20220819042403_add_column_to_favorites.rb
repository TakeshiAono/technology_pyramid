class AddColumnToFavorites < ActiveRecord::Migration[6.0]
  def change
    add_column :favorites, :user_id, :bigint
    add_column :favorites, :favorite_user, :bigint, default: 3
    # add_foreign_key :favorites, :users
    add_foreign_key :favorites, :users, column: :user_id, primariy_key: :id
    add_foreign_key :favorites, :users, column: :favorite_user, primariy_key: :id
  end
end
