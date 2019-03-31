class Genre < ApplicationRecord
  has_many :works, through: :genre_works
  has_many :genre_works

  enum name: {
    # アクション・アドベンチャー
    action_adventure: 0,
    comic_superhero: 1,
    martial_arts_movies: 2,
    # アニメ
    anime: 10,
    adult_anime: 11,
    # キッズ・ファミリー
    children_family: 20,
    tv_cartoons: 21,
    # クラシック
    # コメディ
    comedies: 40,
    # ドキュメンタリー
    # ヒューマンドラマ
    # 外国映画
    korean_movies: 72,
    # ホラー
    horror_movies: 80,
    # 音楽
    # ロマンス
    romantic_movies: 100,
    # SF
    alien_sf: 111,
    # スポーツ
    sports_movies: 120,
    # スリラー
    thrillers: 130,
    # TV
    tv_shows: 140
  }
end
