class CahngeActiveFlagColumnToWorks < ActiveRecord::Migration[6.0]
  def change
    change_column_default :works, :active_flag, from: nil, to: true
  end
end
