class Work < ApplicationRecord
  has_many :reviews
  has_many :genres, through: :genre_works
  has_many :genre_works

  validates :title, presence: true
  validates :year, presence: true
  validates :link, presence: true, uniqueness: true

  def search_reviews
    Review.where(work_id: self.id).order(created_at: 'DESC')
  end

  def self.search(keyword)
    return Work.all unless keyword
    Work.where("title LIKE ?", "%#{keyword}%")
  end
end
