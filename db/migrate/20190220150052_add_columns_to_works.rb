class AddColumnsToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :year, :string, after: :summary
    add_column :works, :runtime, :string, after: :year
    add_column :works, :country, :string, after: :runtime
    add_column :works, :type, :string, after: :country
  end
end
