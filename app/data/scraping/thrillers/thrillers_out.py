import urllib.request, urllib.error, urllib.parse
import time
import datetime
import csv
import pandas as pd
from bs4 import BeautifulSoup

url = 'https://www.netflix.com/jp/browse/genre/8933'
# URLにアクセスする
html = urllib.request.urlopen(url=url)
soup = BeautifulSoup(html, "html.parser")

# ジャンル
genre = soup.find('h1', class_='nm-collections-header-name').text

tag_ids = soup.find_all('a', class_='nm-collections-title')
tag_titles = soup.find_all('span', class_='nm-collections-title-name')

ids = []
titles = []
years = []

# https://www.netflix.com/jp/title/ID からIDのみ取り出す
for tag_id in tag_ids:
  href = tag_id.attrs['href']
  path = urllib.parse.urlparse(href).path
  id_ = path[10:]
  ids.append(id_)

  # 詳細ページから年を取り出す
  url_single = 'https://www.netflix.com/jp/title/%s' % id_
  html_single = urllib.request.urlopen(url=url_single)
  soup_single = BeautifulSoup(html_single, "html.parser")
  # 見つからない場合は None
  year = soup_single.find('span', class_='item-year').text
  years.append(year)

  # 現在時間表示
  print(datetime.datetime.now())

  # 10秒間隔を空ける
  time.sleep(10)

# タイトル
for tag_title in tag_titles:
  title = tag_title.text
  titles.append(title)

# CSVにデータを保存する
df = pd.DataFrame({'Genre': genre, 'ID': ids, 'Title': titles, 'Year': years})
df.to_csv('app/data/csv/thrillers/thrillers.csv')
