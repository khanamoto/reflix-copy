class GenreWork < ApplicationRecord
  belongs_to :genre
  belongs_to :work
end
