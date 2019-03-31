class AddLinkToWork < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :link, :string, after: :image
  end
end
