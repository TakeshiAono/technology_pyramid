class CreateLinkAccessCounters < ActiveRecord::Migration[6.0]
  def change
    create_table :link_access_counters do |t|
      t.references :pyramid, null: false, foreign_key: true
      t.references :link, null: false, foreign_key: true
      t.integer :counter

      t.timestamps
    end
  end
end
