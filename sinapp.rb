require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'rchardet19'
require 'mysql'
require './crawler'


get "/" do
    puts 'hello sinatra'
    crawler = Crawler.new('213101579', '13-14-2')
    crawler.crawlsite()
    crawler.getStudentInfo()
    crawler.getCourseInfo()
end

get "/hello/:name" do
   puts params[:name]
   name = params[:name]
   "hello #{name}"
end


