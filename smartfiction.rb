require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require 'uri'
require 'restclient'

doc = Nokogiri::HTML(open "http://www.smartfiction.ru/")

doc.css('div.post').each do |post|
  name_and_athor = post.css('h2').first.text
  response = JSON.parse RestClient.get(URI.escape("https://bookmate.com/a/4/search.json?query=#{name_and_athor}"))

  next unless book = response['documents']['objects'].first
  book_uuid = book["uuid"]
end
