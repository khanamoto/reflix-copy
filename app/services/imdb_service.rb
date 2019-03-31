class ImdbService
  def get_image_by_title(title, year)
    response = HTTP.get("http://www.omdbapi.com/?apikey=#{ENV["OMDB_API_KEY"]}&t=#{title}&y=#{year}").to_s
    parsed_response = JSON.parse(response)
    JSON.parse(response)

    # parsed_response
    # parsed_response["Year"]
    # parsed_response["Runtime"]
    # parsed_response["Country"]
    # N/Aが返ったらCSV該当タイトルを空にすること
    parsed_response["Poster"]
    # parsed_response["Type"]
  end
end
