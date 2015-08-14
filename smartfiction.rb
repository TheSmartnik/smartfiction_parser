require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require 'uri'
require 'restclient'

doc = Nokogiri::HTML(open "http://www.smartfiction.ru/")

AUTH_TOKEN = ''

doc.css('div.post').each do |post|
  name_and_athor = post.css('h2').first.text
  response = JSON.parse RestClient.get(URI.escape("https://bookmate.com/a/4/search.json?query=#{name_and_athor}"))

  next unless book = response['documents']['objects'].first
  document_id = book["uuid"]

  response = RestClient.post "http://api.bookmate.com/a/4/bs/DrGXOsPf/d", auth_token: AUTH_TOKEN, id: document_id, d: { annotation: nil }
  puts response
  break
end
