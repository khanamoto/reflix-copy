class ChangeColumnNullToWorks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :works, :title, null: false
    change_column_null :works, :year, null: false
    change_column_null :works, :link, null: false
  end
end
