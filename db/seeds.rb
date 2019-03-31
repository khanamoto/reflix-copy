# name_num = %w(
#   0 1 2
# d
# )
# name_num.each do |num|
#   Genre.create!(name: num.to_i)
# end

# 管理者アカウント作成
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# 初期作品データ投入
require 'csv'

columns = []
paths = %w(
  db/initial_data/action_adventure.csv
  db/initial_data/comic_superhero.csv
  db/initial_data/martial_arts_movies.csv
  db/initial_data/adult_anime.csv
  db/initial_data/anime.csv
)

paths.each do |path|
  CSV.foreach(path, headers: true) do |row|
    title_jp = row['Title']
    title_en = row['TitleEnglish']
    year = row['Year']
    link_id = row['ID']

    if row['TitleEnglish'].present?
      hash = ImdbService.new
      escaped_title = URI.escape(title_en)
      image = hash.get_image_by_title(escaped_title, year)
    else
      image = ''
    end

    columns << {
      title: title_jp,
      year: year,
      image: image,
      link: link_id,
    }
  end
end

## 同作品はバリデーションで弾くため、例外処理は不要
Work.create(columns)
