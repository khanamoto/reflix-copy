import os
import sys
import urllib.parse
import csv
import pandas as pd
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

if __name__ == '__main__':
  chrome_options = Options()
  chrome_options.add_argument('--headless')
  driver = webdriver.Chrome(executable_path='/usr/local/bin/chromedriver', chrome_options=chrome_options)

  # ログイン
  driver.get('https://www.netflix.com/jp/login')
  # 以下のIDとPASSWORDはホストPCの環境変数に設定すること
  driver.find_element_by_name('userLoginId').send_keys(os.environ['NETFLIX_LOGIN_ID'])
  driver.find_element_by_name('password').send_keys(os.environ['NETFLIX_LOGIN_PASSWORD'])

  driver.find_element_by_class_name('login-button').click()

  # カテゴリページに移動
  # 変更点: genre/●●●●
  driver.get('https://www.netflix.com/browse/genre/1365')

  html = driver.page_source.encode('utf-8')
  soup = BeautifulSoup(html, 'html.parser')
  contents = soup.find_all('a', class_='slider-refocus')

  titles = []
  ids = []
  for content in contents:
    title = content.attrs['aria-label']
    titles.append(title)

    # pathからID抽出
    url = content.attrs['href']
    path = urllib.parse.urlparse(url).path
    id_ = path[7:]
    ids.append(id_)

  genre = driver.find_element_by_class_name('genreTitle').text

  # CSVにデータを保存する
  # 変更点: csv/●●●●/●●●●.csv
  df = pd.DataFrame({'Genre': genre, 'Title': titles, 'ID': ids})
  df.to_csv('app/scrapes/csv/action_adventure/action_adventure.csv')

  # ブラウザ終了
  driver.quit()
