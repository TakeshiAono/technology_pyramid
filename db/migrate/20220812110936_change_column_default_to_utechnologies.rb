class ChangeColumnDefaultToUtechnologies < ActiveRecord::Migration[6.0]
  def change
    change_column_default :technologies, :basic_flag, from: nil, to: true
  end
end
