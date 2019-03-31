class AddIndexToWorks < ActiveRecord::Migration[5.2]
  def change
    add_index :works, :title
    add_index :works, :link, unique: true
  end
end
