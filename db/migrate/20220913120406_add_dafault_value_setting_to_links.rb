class AddDafaultValueSettingToLinks < ActiveRecord::Migration[6.0]
  def change
    change_column_default :links, :good_counter, from: nil, to: 0
  end
end
