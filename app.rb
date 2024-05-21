require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("FX_KEY")}"
  @raw_response = HTTP.get(api_url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)
  @all_currencies = @parsed_data.fetch("currencies")
  
  
  erb(:homepage)

end


get("/:from_currency") do
  
  @the_currency = params.fetch("from_currency")

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("FX_KEY")}"

  @raw_response = HTTP.get(api_url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)
  @all_currencies = @parsed_data.fetch("currencies")
  
  erb(:step_one)
end

get("/:from_currency/:to_currency") do
  @from = params.fetch("from_currency")
  @to = params.fetch("to_currency")

  @convert_url = "https://api.exchangerate.host/convert?from=#{@from}&to=#{@to}&amount=1&access_key=#{ENV.fetch("FX_KEY")}"

  @raw_response = HTTP.get(@convert_url)
  @string_response = @raw_response.to_s
  @parsed_response = JSON.parse(@string_response)
  @amount = @parsed_response.fetch("result")

  erb(:second_step)
end
