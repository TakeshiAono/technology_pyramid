class CreateLinkGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :link_goods do |t|
      t.references :link, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
