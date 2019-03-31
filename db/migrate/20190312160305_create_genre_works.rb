class CreateGenreWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :genre_works do |t|
      t.references :genre, foreign_key: true
      t.references :work, foreign_key: true

      t.timestamps
    end
  end
end
